//
//  EventsViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var eventsTable: UITableView!
    
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
        
        let title = eventMgr.events[indexPath.row].title
        
        let date = NSDateFormatter.localizedStringFromDate(eventMgr.events[indexPath.row].startDate, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        
        let startTime = NSDateFormatter.localizedStringFromDate(eventMgr.events[indexPath.row].startDate, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)

        let endTime = NSDateFormatter.localizedStringFromDate(eventMgr.events[indexPath.row].endDate, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        
        let time = "\(startTime)-\(endTime)"

        alert.title = title
        alert.message = "\(eventMgr.events[indexPath.row].location)\n\(date)\n\(time)\n\n\(eventMgr.events[indexPath.row].description)"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }

}

