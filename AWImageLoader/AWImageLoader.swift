//
//  AWImageLoader.swift
//  AWImageLoader
//
//  Created by 秦 道平 on 15/9/23.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import Foundation
import UIKit

private let _sharedLoader : AWImageLoader = AWImageLoader()

typealias AWImageLoaderCallback = (UIImage,NSURL)->()
typealias AWImageLoaderCallbackList = [AWImageLoaderCallback]

class AWImageLoader :NSObject{
    private let name:String!
    static var sharedLoader:AWImageLoader! {
        return _sharedLoader
    }
    var fetchList:[String:AWImageLoaderCallbackList] = [:]
    var fetchQueue : dispatch_queue_t!
    var sessionQueue = NSOperationQueue()
    var session : NSURLSession!
    var memoryCache:NSCache!
    init(name:String){
        self.name = name
        super.init()
        self.fetchQueue = dispatch_queue_create("\(name).queue.fetch.barrier", DISPATCH_QUEUE_CONCURRENT)
        sessionQueue.name = "\(name).queue.session"
        sessionQueue.maxConcurrentOperationCount = 3
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: sessionQueue)
        memoryCache = NSCache()
        memoryCache.totalCostLimit = 10 * 1024 * 1024
        let urlCache = NSURLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: "awimageloader.urlcache")
        NSURLCache.setSharedURLCache(urlCache)
    }
    convenience override init(){
        self.init(name:"awimageloader.shared")
    }
}
extension AWImageLoader{
    /// 写如url
    private func appendFetchKey(key:String,completionBlockList:AWImageLoaderCallbackList){
        dispatch_barrier_sync(fetchQueue) { [unowned self]() -> Void in
            self.fetchList[key] = completionBlockList
//            NSLog("append fetch:%@",key)
        }
    }
    private func removeFetchKey(key:String){
        dispatch_barrier_sync(fetchQueue) { () -> Void in
            self.fetchList.removeValueForKey(key)
//            NSLog("remove fetch:%@",key)
        }
    }
    /// 下载
    func downloadImage(url:NSURL, onSucess completionBlock:AWImageLoaderCallback){
        let key = url.absoluteString
        /// 先从 NSCache 中获取图片
        if let image = self.memoryCache.objectForKey(key) as? UIImage {
//            NSLog("image from memory cache:%@",key)
            completionBlock(image,url)
            return
        }
        let request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.addValue("private", forHTTPHeaderField: "Cache-Control")
        /// 从url获取图片
        if let cache_result = NSURLCache.sharedURLCache().cachedResponseForRequest(request) {
            if let image = UIImage(data: cache_result.data) {
                /// 写入 NSCache
                self.memoryCache.setObject(image, forKey: key)
//                NSLog("image from urlcache:%@",key)
                completionBlock(image,url)
                return
            }
        }
        /// 使用 url 下载图片
        /// 先确保 url 路径不会倍重复下载,如果正在下载的，会针对这个 url 添加一个回调
        if var callback_list = self.fetchList[key] {
//            NSLog("downloading: %@",key)
            callback_list.append(completionBlock)
            self.appendFetchKey(key, completionBlockList: callback_list)
            return
        }
        else{
//            NSLog("append key:%@",key)
            let callback_list  = [completionBlock,]
            self.appendFetchKey(key, completionBlockList: callback_list)
        }
        
        
        let dataTask = session.dataTaskWithRequest(request) { [unowned self](data, response, error) -> Void in
            guard let error = error else {
                if let data = data,callback_list = self.fetchList[key] {
                    self.removeFetchKey(key)
                    let image = UIImage(data: data)!
                    /// 写入 NSCache
                    self.memoryCache.setObject(image, forKey: key)
//                    NSThread.sleepForTimeInterval(3.0)
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        for (_,f) in callback_list.enumerate() {
//                            NSLog("callback:%d,%@",i,url)
                            f(image,url)
                        }    
                    })
                    
                }
                return
            }
            self.removeFetchKey(key)
            NSLog("error:%@",error)
        }
        dataTask.resume()
    }
}
extension AWImageLoader {
    func clearCache(){
        self.memoryCache.removeAllObjects()
        NSURLCache.sharedURLCache().removeAllCachedResponses()
    }
}
extension AWImageLoader:NSURLSessionDelegate,NSURLSessionDataDelegate {
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        NSLog("error:%@",error!)
    }
}

func aw_download_image(url:NSURL!, completionBlock:AWImageLoaderCallback){
    AWImageLoader.sharedLoader.downloadImage(url, onSucess: completionBlock)
}
func aw_download_image_c(url:NSURL!)(completionBlock:AWImageLoaderCallback){
    AWImageLoader.sharedLoader.downloadImage(url, onSucess: completionBlock)
}