//
//  RaffleViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class RaffleViewController: UITableViewController {

    @IBOutlet var raffleTableView: UITableView!
    
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
        var cell = tableView.dequeueReusableCellWithIdentifier("TableViewRaffleCell", forIndexPath: indexPath) as UITableViewCell
        
        (cell.contentView.viewWithTag(1) as UILabel).text = eventMgr.events[indexPath.row].name
        (cell.contentView.viewWithTag(2) as UILabel).text = eventMgr.events[indexPath.row].raffle.timeRemaining
        (cell.contentView.viewWithTag(3) as UIButton).setTitle("Enter", forState: .Normal)
        
        return cell
    }
    
    // On selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert: UIAlertView = UIAlertView()
        
        let e = eventMgr.events[indexPath.row]
        
        alert.title = e.name
        alert.message = "\(e.location)\n\(e.dateStr.day)\n\(e.dateStr.startTime) - \(e.dateStr.endTime)\n\n\(e.description)"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }

}

