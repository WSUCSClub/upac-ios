//
//  AboutViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var secretButton: UITextView!
    @IBOutlet var boardTable: UITableView!
    @IBOutlet var addMemberButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var longPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("showLogin:"))
        longPressRecognizer.minimumPressDuration = 3
        secretButton.addGestureRecognizer(longPressRecognizer)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardMgr.list.count
    }
    
    // Need to set row height explicitly or else collapses on table reload
    // FIXED: Interface Builder -> tableView -> rowHeight
    //func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //    return 75
    //}
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = boardTable.dequeueReusableCellWithIdentifier("boardMemberCell", forIndexPath:indexPath) as UITableViewCell
        
        var m = boardMgr.list[indexPath.row] as Member
        
        if raffleMgr.adminPrivileges == true {
            (cell.contentView.viewWithTag(5) as UIButton).hidden = false
        } else {
            (cell.contentView.viewWithTag(5) as UIButton).hidden = true
        }
        
        // Format img circle
        var image: UIImageView = (cell.contentView.viewWithTag(1) as UIImageView)
        image.image = UIImage(named: m.picture)
        var mask = image.layer
        mask.cornerRadius = image.frame.size.width / 2
        mask.masksToBounds = true
        (cell.contentView.viewWithTag(2) as UILabel).text = m.name
        (cell.contentView.viewWithTag(3) as UILabel).text = m.position
        (cell.contentView.viewWithTag(4) as UILabel).text = m.email
        
        return cell
    }
    
    // Allow cell swiping
    /*func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //add code here for when you hit delete
            println("delete member at list[indexpath.row]")
        }
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected member")
    }
    
    
    func showLogin(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            var loginAlert = UIAlertController(title: "Login", message: "Enter your password", preferredStyle: .Alert)
            loginAlert.view.tintColor = UIColor.blueColor()

            
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
                    self.boardTable.reloadData()
                    self.addMemberButton.hidden = false
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
    
    @IBAction func addMember() {
        println("add member")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

