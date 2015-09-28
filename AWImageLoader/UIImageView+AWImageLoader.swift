//
//  UIImageView+AWImageLoader.swift
//  AWImageLoader
//
//  Created by 秦 道平 on 15/9/28.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import Foundation
import UIKit

private var imageUrlKey : Void?
extension UIImageView {
    /// 下载的 imageurl
    var aw_image_url : NSURL? {
        get{
            return objc_getAssociatedObject(self, &imageUrlKey) as? NSURL
        }
        set {
            objc_setAssociatedObject(self, &imageUrlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 下载图片,如果有 delay 参数，那他会在 NSDefaultRunLoopMode 模式下运行
    func aw_downloadImageURL_delay(url:NSURL,delay:Bool,completionBlock:AWImageLoaderCallback){
        /// 先设置要下载的图片地址
        self.aw_image_url = url
        aw_download_image(url) { [weak self](image, url) -> () in
            guard let _self = self, let _aw_image_url = _self.aw_image_url else {
                return
            }
            /// 校验一下现在是否还需要显示这个地址的图片
            if _aw_image_url.absoluteString != url.absoluteString {
                NSLog("url not match:%@,%@", _aw_image_url,url)
            }
            else{
                if delay {
                    self?.performSelector("aw_set_image:", withObject: image, afterDelay: 0.0, inModes: [NSDefaultRunLoopMode])
                }
                else{
                    self?.image = image
                }
                completionBlock(image,url)
            }
        }
    }
    /// 直接在在所有模式贴图
    func aw_downloadImageURL(url:NSURL,completionBlock:AWImageLoaderCallback){
        self.aw_downloadImageURL_delay(url, delay: false, completionBlock: completionBlock)
    }
    func aw_setImage(image:UIImage){
        self.image = image
    }
}