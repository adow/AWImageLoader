//
//  ThirdViewController.swift
//  AWImageLoader
//
//  Created by 秦 道平 on 15/9/24.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import Foundation
import UIKit

class ThirdViewController:UIViewController {
    @IBOutlet var imageView_1:UIImageView!
    @IBOutlet var imageView_2:UIImageView!
    @IBOutlet var imageView_3:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("ThirdViewController start load")
        let url = NSURL(string: "https://cdn.v2ex.co/avatar/b3e3/e393/153_large.png?m=1343023766")!
//        AWImageLoader.sharedLoader.downloadImage(url) { [weak self](image) -> () in
//            self?.imageView_1.image = image
//            NSLog("image 1 done")
//        }
//        AWImageLoader.sharedLoader.downloadImage(url) { [weak self](image) -> () in
//            self?.imageView_2.image = image
//            NSLog("image 2 done")
//        }
//        AWImageLoader.sharedLoader.downloadImage(NSURL(string: "https://cdn.v2ex.co/site/logo@2x.png?m=1346064962")!) { [weak self](image) -> () in
//            self?.imageView_3.image = image
//            NSLog("image 3 done")
//        }
        let f = aw_download_image_c(url)
        f { [weak self](image,url) -> () in
            self?.imageView_1.image = image
            NSLog("image 1 done")
        }
        f { [weak self](image,url) -> () in
            self?.imageView_2.image = image
            NSLog("image 2 done")
        }
        aw_download_image(NSURL(string: "https://cdn.v2ex.co/site/logo@2x.png?m=1346064962")!) {
            [weak self](image,url) -> () in
            self?.imageView_3.image = image
            NSLog("image 3 done")
        }
        NSLog("ThirdViewController end load")
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
        NSLog("ThirdViewController dealloc")
    }
}
extension ThirdViewController{
    @IBAction func onButtonDismiss(sender:UIButton!){
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("ThirdViewController dismissed")
        }
    }
}