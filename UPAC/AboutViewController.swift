//
//  AboutViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

//TODO: Add staff directory

import UIKit

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func linkToFacebook() {
        // Open browser to UPAC Facebook group page
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/WSU.UPAC")!)
    }
}

