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
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
        eventsTableView.addSubview(refreshControl!)
        onboarding()
    }
    
    func onboarding() {
        // Onboarding
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("firstRun")
        if NSUserDefaults.standardUserDefaults().objectForKey("firstRun") == nil {
            var onboardingTitle = "How Raffles Work"
            var onboardingMessage = "\nJust tap the \"Enter Raffle\" button to enter the event's raffle for a chance to win a prize, then during the event UPAC will announce the winners that are chosen at random.\n\nRULES\n* Free to enter\n* No sign-up required\n* Drawings are held at their respective event's location\n* Must be present at event to win\n* Must show raffle ticket # on device to UPAC host to receive prize\n* Must be current Winona State University student to be eligible\n\nNOTE\nApple is not a sponsor of these raffles, nor are they involved in any way."
            
            var alert = UIAlertController(title: onboardingTitle, message: onboardingMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.view.tintColor = UIColor.blueColor()
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            NSUserDefaults.standardUserDefaults().setObject(false, forKey: "firstRun")
        }
    }
    
    func refresh() {
        raffleMgr.getRaffles()
        eventMgr.getFBEvents { void in self.refreshControl!.endRefreshing() }
    }
    
    // Tell user to refresh if unable to load events
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {        
        if eventMgr.list.count < 1 {
            var loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            loadingIndicator.color = UIColor.grayColor()
            loadingIndicator.startAnimating()
            
            eventsTableView.backgroundView = loadingIndicator
            eventsTableView.separatorStyle = .None
            
            return 0
        } else {
            eventsTableView.backgroundView = nil
            eventsTableView.separatorStyle = .SingleLine
            
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventMgr.list.count
    }

    // Set cell content
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if !eventMgr.list.isEmpty {
            let e = eventMgr.list[indexPath.row] as Event
            
            // Use different layout if event has a raffle
            var cellIdentifier: String
            if e.hasRaffle() {
                cellIdentifier = "TableViewEventRaffleCell"
            } else {
                cellIdentifier = "TableViewEventCell"
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            
            (cell.contentView.viewWithTag(1) as! UILabel).text = e.name
            (cell.contentView.viewWithTag(2) as! UILabel).text = "\(e.date.monthStr()) \(e.date.dayNumStr()) @ \(e.location)"
            (cell.contentView.viewWithTag(3) as! UIImageView).image = UIImage(data: e.imageData)
            cell.contentView.viewWithTag(3)!.layer.borderColor = UIColor(rgb: 0x888888).CGColor
            
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier("TableViewEventCell", forIndexPath: indexPath) as! UITableViewCell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // On selection functionality
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EventDetailView" || segue.identifier == "EventDetailRaffleView" {
            let destinationView:EventDetailViewController = segue.destinationViewController as! EventDetailViewController
            
            let indexPath:NSIndexPath = self.eventsTableView.indexPathForCell(sender as! UITableViewCell)!
            
            destinationView.delegate = self
            destinationView.event = eventMgr.list[indexPath.row] as Event
            destinationView.index = indexPath.row
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
