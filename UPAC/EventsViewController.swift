//
//  EventsViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/9/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

var __eventsTableView: UITableView? = nil

class EventsViewController: UITableViewController {
    @IBOutlet var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        __eventsTableView = eventsTableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventMgr.list.count
    }

    // Set cell content
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let e = eventMgr.list[indexPath.row] as Event
        
        // Use different layout if event has a raffle
        var cellIdentifier: String
        if e.hasRaffle() {
            cellIdentifier = "TableViewEventRaffleCell"
        } else {
            cellIdentifier = "TableViewEventCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        // Format date circle
        var image = (cell.contentView.viewWithTag(1) as UIImageView)
        var mask = image.layer
        mask.cornerRadius = image.frame.size.width / 2
        mask.masksToBounds = true
        (cell.contentView.viewWithTag(2) as UILabel).text = e.date.weekdayStr()
        (cell.contentView.viewWithTag(3) as UILabel).text = e.date.dayNumStr()
        
        (cell.contentView.viewWithTag(4) as UILabel).text = e.name
        (cell.contentView.viewWithTag(5) as UILabel).text = e.location
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // On selection functionality
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EventDetailView" || segue.identifier == "EventDetailRaffleView" {
            let destinationView:EventDetailViewController = segue.destinationViewController as EventDetailViewController
            
            let indexPath:NSIndexPath = self.eventsTableView.indexPathForCell(sender as UITableViewCell)!
            
            destinationView.delegate = self
            destinationView.event = eventMgr.list[indexPath.row] as Event
            destinationView.index = indexPath.row
        }
    }

}
