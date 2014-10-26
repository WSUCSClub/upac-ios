//
//  ImageViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/12/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var fullImageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    var picture:Picture!

    override func viewDidLoad() {
        super.viewDidLoad()

        fullImageView.image = UIImage(named: picture.src)
        dateLabel.text = picture.date.dayStr()
        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("toggleUI"))
        fullImageView.addGestureRecognizer(tapGesture)

    }

    func toggleUI() {
        if dateLabel.hidden {
            dateLabel.hidden = false
            backButton.hidden = false
        } else {
            dateLabel.hidden = true
            backButton.hidden = true
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
