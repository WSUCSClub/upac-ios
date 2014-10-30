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

        var image = (cell.contentView.viewWithTag(1) as UIImageView)
        image.image = UIImage(named: e.image)
        // Apply circle mask
        //var mask = image.layer
        //mask.cornerRadius = image.frame.size.width / 2
        //mask.masksToBounds = true
        
        (cell.contentView.viewWithTag(2) as UILabel).text = e.name
        (cell.contentView.viewWithTag(3) as UILabel).text = e.location
        (cell.contentView.viewWithTag(4) as UILabel).text = e.date.dayStr()
        
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
