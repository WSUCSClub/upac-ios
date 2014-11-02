//
//  ContactViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/1/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import UIKit

class ContactViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func linkToFacebook() {
        // Open browser to UPAC Facebook group page
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/WSU.UPAC")!)
    }
    
    @IBAction func linkToTwitter() {
        // Open browser to UPAC Twitter page
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/UPACWSU")!)
    }
    
    @IBAction func linkToEmail() {
        // Open mail app
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:upac@winona.edu")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

