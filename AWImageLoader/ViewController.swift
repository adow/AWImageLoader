//
//  ViewController.swift
//  AWImageLoader
//
//  Created by 秦 道平 on 15/9/23.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        NSLog("viewDidLoad start")
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
//            NSLog("background work start")
//            NSThread.sleepForTimeInterval(10.0)
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//                self.label.text = "\(NSDate())"
//            })
//            NSLog("background work end")
//        }
//        NSLog("viewDidLoad end")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

