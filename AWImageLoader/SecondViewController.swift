//
//  SecondViewController.swift
//  AWImageLoader
//
//  Created by 秦 道平 on 15/9/24.
//  Copyright © 2015年 秦 道平. All rights reserved.
//

import Foundation
import UIKit

class ImageTableViewCell:UITableViewCell {
    @IBOutlet var showImageView:UIImageView!
    var link:String!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.showImageView.backgroundColor = UIColor.lightGrayColor()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.showImageView.image = nil
//        self.showImageView.hidden = true
    }
}

class SecondViewController : UIViewController {
    var links : [String]!
    @IBOutlet var tableView:UITableView!
    lazy var callback:()->() = {
        () -> () in
        NSLog("background work start")
        
        NSLog("background work end")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("SecondviewDidLoad start")
       self.links = [
            "https://static.pexels.com/photos/9226/animals-birds-owl-fauna-medium.jpg",
            "https://static.pexels.com/photos/8573/boat-medium.jpg",
            "https://static.pexels.com/photos/9226/animals-birds-owl-fauna-medium.jpg",
            "https://static.pexels.com/photos/9226/animals-birds-owl-fauna-medium.jpg",
            "https://static.pexels.com/photos/8827/road-man-lights-legs-medium.jpg",
            "https://static.pexels.com/photos/7941/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/9226/animals-birds-owl-fauna-medium.jpg",
            "https://static.pexels.com/photos/9053/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/7531/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/8884/pexels-photo-medium.jpeg",
            "https://static.pexels.com/photos/7934/night-skyline-usa-manhattan-medium.jpg",
            "https://static.pexels.com/photos/8204/night-medium.jpg",
            "https://static.pexels.com/photos/7870/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/9453/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/8748/wood-lake-moss-tree-medium.jpg",
            "https://static.pexels.com/photos/6704/nature-sky-sunset-man-medium.jpg",
            "https://static.pexels.com/photos/9417/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/7764/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/8190/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/8614/painting-black-paint-roller-medium.jpg",
            "https://static.pexels.com/photos/8947/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/7907/food-pizza-slice-fast-food-medium.jpg",
            "https://static.pexels.com/photos/8485/water-lake-nyon-medium.jpeg",
            "https://static.pexels.com/photos/7062/man-people-space-desk-medium.jpg",
            "https://static.pexels.com/photos/7868/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/8983/pexels-photo-medium.jpeg",
            "https://static.pexels.com/photos/9234/landscape-sunset-sun-orange-medium.jpg",
            "https://static.pexels.com/photos/9186/food-beans-coffee-drink-medium.jpg",
            "https://static.pexels.com/photos/6805/fashion-men-vintage-colorful-medium.jpg",
            "https://static.pexels.com/photos/9090/sunset-summer-motorcycle-medium.jpg",
            "https://static.pexels.com/photos/7039/pexels-photo-medium.jpeg",
            "https://static.pexels.com/photos/9305/beach-holiday-clouds-lifeguard-medium.jpg",
            "https://static.pexels.com/photos/7543/pexels-photo-medium.jpeg",
            "https://static.pexels.com/photos/9142/pepper-pepper-mill-medium.jpg",
            "https://static.pexels.com/photos/8558/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/8097/usa-stock-ny-new-york-medium.jpg",
            "https://static.pexels.com/photos/8640/pexels-photo-medium.jpg",
            "https://static.pexels.com/photos/6710/light-fashion-hands-woman-medium.jpg",
            "https://static.pexels.com/photos/8115/suit-couple-blue-shoes-medium.jpg",
        ]
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
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
extension SecondViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.links != nil ? self.links.count : 0
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell-image") as! ImageTableViewCell
        let link = self.links[indexPath.row]
        cell.link = link
//        aw_download_image(NSURL(string: link)) { (image,url) -> () in
//            if url.absoluteString != cell.link {
//                NSLog("cell not match:%@,%@",url.absoluteString,cell.link)
//            }
//            else{
////                NSLog("%@,%@",unsafeAddressOf(cell),url.absoluteString)
//                cell.showImageView.image = image
//            }
//        }
        cell.showImageView.aw_downloadImageURL(NSURL(string: link)!) { (image, url) -> () in
            
        }
        return cell
    }
}
extension SecondViewController {
    @IBAction func onButtonDismiss(sender:UIButton!){
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("SecondViewController dismissed")
        }
    }
    @IBAction func onButtonClear(sender:UIButton!){
        AWImageLoader.sharedLoader.clearCache()
    }
}