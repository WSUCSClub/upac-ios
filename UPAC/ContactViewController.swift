//
//  AboutViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

var __boardTableView: UITableView? = nil

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var boardTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        __boardTableView = boardTable
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardMgr.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = boardTable.dequeueReusableCellWithIdentifier("boardMemberCell", forIndexPath:indexPath) as UITableViewCell
        
        var m = boardMgr.list[indexPath.row] as Member
        
        // Format img circle
        var image: UIImageView = (cell.contentView.viewWithTag(1) as UIImageView)
        dispatch_async(dispatch_get_main_queue()) {
            image.image = UIImage(data: m.picture)
        }
        var mask = image.layer
        mask.cornerRadius = image.frame.size.width / 2
        mask.masksToBounds = true
        (cell.contentView.viewWithTag(2) as UILabel).text = m.name
        (cell.contentView.viewWithTag(3) as UILabel).text = m.position
        (cell.contentView.viewWithTag(4) as UILabel).text = m.email
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Send selected member an email
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:\((boardMgr.list[indexPath.row] as Member).email)")!)

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

