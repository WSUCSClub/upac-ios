//
//  AboutViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet var copyrightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("showLogin:"))
        longPressRecognizer.minimumPressDuration = 3
        copyrightLabel.addGestureRecognizer(longPressRecognizer)
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
    
    func showLogin(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            var loginAlert = UIAlertController(title: "Login", message: "Enter your password", preferredStyle: .Alert)
            
            var inputPasswordField = UITextField()
            loginAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
                textField.placeholder = "Password"
                textField.secureTextEntry = true
                inputPasswordField = textField
            }
            
            var cancel = UIAlertAction(title: "Cancel", style: .Default) { (action) -> Void in }
            loginAlert.addAction(cancel)

            var ok = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
                if self.attemptLogin(inputPasswordField.text) {
                    // Enable admin controls
                    raffleMgr.adminPrivileges = true
                }
                }
            loginAlert.addAction(ok)
            
            // Need to wrap presentation to prevent warning
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(loginAlert, animated: true, completion: nil)
                }
        }
    }
    
    func attemptLogin(password: String) -> Bool {
        //TODO: hash password
        var passwordHash = password
        
        //TODO: get valid password
        var validPasswordHash = "asdf"
        
        var loginSuccess: Bool
        if passwordHash == validPasswordHash {
            loginSuccess = true
        } else {
            loginSuccess = false
        }
        
        return loginSuccess
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

