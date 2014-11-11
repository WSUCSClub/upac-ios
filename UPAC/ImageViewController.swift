//
//  ImageViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/12/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit
import QuartzCore

class ImageViewController: UIViewController {
    @IBOutlet var fullImageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    var picture: Picture!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
        
        // Create rounded border around back button
        backButton.layer.borderWidth = 1.5
        backButton.layer.borderColor = UIColor.whiteColor().CGColor
        backButton.layer.cornerRadius = 3.0
        backButton.layer.masksToBounds = true
        
        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("toggleUI"))
        fullImageView.addGestureRecognizer(tapGesture)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("moveToNextPicture"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("moveToPreviousPicture"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func updateView() {
        // Use full image if available, otherwise continue using thumbnail
        dispatch_async(dispatch_get_main_queue()) {
            if let data = NSData(contentsOfURL: NSURL(string:self.picture.src)!) {
                self.fullImageView.image = UIImage(data: data)
            } else {
                self.fullImageView.image = UIImage(data: self.picture.data)
            }
        }
        
        
        dateLabel.text = picture.date.dayStr()
    }

    func toggleUI() {
        if dateLabel.hidden {
            dateLabel.hidden = false
            backButton.hidden = false
            UIApplication.sharedApplication().statusBarHidden = false
        } else {
            dateLabel.hidden = true
            backButton.hidden = true
            UIApplication.sharedApplication().statusBarHidden = true
        }
    }
    
    func moveToNextPicture() {
        if index + 1 < galleryMgr.list.count {
            index?++
            picture = galleryMgr.list[index] as Picture
            
            updateView()
        }

    }
    
    func moveToPreviousPicture() {
        if index - 1 >= 0 {
            index?--
            picture = galleryMgr.list[index] as Picture
            
            updateView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backAction(sender:AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
