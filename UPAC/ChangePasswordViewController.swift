//
//  ChangePasswordViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/2/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet var oldPasswordField: UITextField!
    @IBOutlet var newPasswordField: UITextField!
    @IBOutlet var confirmNewField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func savePassword(newPassword: String) {
        // Update on Parse
        var query = PFQuery(className: "Login")
        query.getFirstObjectInBackgroundWithBlock { login, error in
            login["password"] = newPassword.md5()
            login.saveInBackgroundWithBlock { void in }
        }
        
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        var errorMsg: String? = validateInput()
        if let errorMsg = errorMsg {
            var errorAlert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .Alert)
            errorAlert.view.tintColor = UIColor.blueColor()
            
            var ok = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in }
            errorAlert.addAction(ok)
            
            // Need to wrap presentation to prevent warning
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
            
        } else {
            savePassword(newPasswordField.text)
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    func validateInput() -> String? {
        var result: String? = nil
        
        if newPasswordField.text == "" {
            result = "Please enter a valid new password"
        }
        
        if newPasswordField.text != confirmNewField.text {
            result = "Passwords do not match"
        }
        
        if !AboutViewController.attemptLogin(oldPasswordField.text) {
            result = "Your current password is invalid"
        }
        
        return result
    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }
    
}
