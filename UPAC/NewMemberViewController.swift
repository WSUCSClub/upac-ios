//
//  NewMemberViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/2/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//


import UIKit

class NewMemberViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var positionField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var pictureField: UITextField!
    
    var boardTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func saveMember() {
        var name = nameField.text
        var position = positionField.text
        var email = emailField.text
        var picture = pictureField.text
        
        boardMgr.addMember(String("\(NSDate())"),
            name: name,
            position: position,
            email: email,
            picture: picture)
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
            saveMember()
            self.navigationController!.popViewControllerAnimated(true)
        }
        
    }
    
    func validateInput() -> String? {
        var result: String?
        
        if nameField.text      != "" &&
            positionField.text != "" &&
            emailField.text    != "" &&
            pictureField.text  != "" {
                result = nil
        } else {
            result = "All fields are required"
        }
        
        return result
    }
    
    override func viewDidDisappear(animated: Bool) {
        boardTable.reloadData()
    }
    
}
