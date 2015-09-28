//
//  SecondViewController.swift
//  AWImageLoader
//
//  Created by 秦 道平 on 15/9/24.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController : UIViewController {
    @IBOutlet var label:UILabel!
    lazy var callback:()->() = {
        () -> () in
        NSLog("background work start")
//        NSThread.sleepForTimeInterval(10.0)
        self.label.text = "\(NSDate())"
//        dispatch_sync(dispatch_get_main_queue(), { [weak self]() -> Void in
//            self.label.text = "\(NSDate())"
//        })
        NSLog("background work end")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("SecondviewDidLoad start")
//        self.callback()
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
//            [weak self]() -> Void in
//            NSLog("background work start")
//            NSThread.sleepForTimeInterval(10.0)
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//                self?.label.text = "\(NSDate())"
//            })
//            NSLog("background work end")
//        }
       
        let url = NSURL(string: "")!
        AWImageLoader.sharedLoader.downloadImage(url) { (image) -> () in
            
        }
        
        NSLog("SecondviewDidLoad end")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    deinit{
        NSLog("SecondViewController dealloc")
    }
}
extension SecondViewController {
    @IBAction func onButtonDismiss(sender:UIButton!){
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("SecondViewController dismissed")
        }
    }
}