//
//  DiscountsViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

//TODO: Implement

import UIKit

class DiscountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var discountsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventMgr.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        cell.textLabel?.text = eventMgr.events[indexPath.row].title
        cell.detailTextLabel?.text = eventMgr.events[indexPath.row].location
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let alert: UIAlertView = UIAlertView()
        
        let e = eventMgr.events[indexPath.row]
        
        alert.title = e.title
        alert.message = "\(e.location)\n\(e.dateStr.day)\n\(e.dateStr.startTime) - \(e.dateStr.endTime)\n\n\(e.description)"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
}