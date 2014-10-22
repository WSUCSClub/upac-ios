//
//  EventsViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {
    @IBOutlet var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventMgr.events.count
    }

    // Set cell content
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TableViewEventCell", forIndexPath: indexPath) as UITableViewCell

        var e = eventMgr.events[indexPath.row]
        
        (cell.contentView.viewWithTag(1) as UIImageView).image = UIImage(named: e.image)
        (cell.contentView.viewWithTag(2) as UILabel).text = e.name
        (cell.contentView.viewWithTag(3) as UILabel).text = e.location
        (cell.contentView.viewWithTag(4) as UILabel).text = e.startDate.dayStr()
        
        return cell
    }
    
    // On selection functionality
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        let alert: UIAlertView = UIAlertView()
        let e = eventMgr.events[indexPath.row]
        alert.title = e.title
        alert.message = "\(e.location)\n\(e.dateStr.day)\n\(e.dateStr.startTime) - \(e.dateStr.endTime)\n\n\(e.description)"
        alert.addButtonWithTitle("OK")
        alert.show()
        */
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EventDetailView") {
            var destinationView:EventDetailViewController = segue.destinationViewController as EventDetailViewController
            
            var indexPath:NSIndexPath = self.eventsTableView.indexPathForCell(sender as UITableViewCell)!
            
            destinationView.event = eventMgr.events[indexPath.row]
        }
    }

}
