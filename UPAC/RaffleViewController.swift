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
        return raffleMgr.list.count
    }
    
    // Set cell content
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TableViewRaffleCell", forIndexPath: indexPath) as UITableViewCell
        
        let raffle = raffleMgr.list[indexPath.row] as Raffle
        
        (cell.contentView.viewWithTag(1) as UILabel).text = raffle.id
        (cell.contentView.viewWithTag(2) as UILabel).text = raffle.timeRemaining
        (cell.contentView.viewWithTag(3) as UIButton).setTitle("Enter", forState: .Normal)
        
        return cell
    }
    
    // On selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert: UIAlertView = UIAlertView()
        
        let e = eventMgr.list[indexPath.row] as Event
        
        alert.title = e.name
        alert.message = "\(e.location)\n\(e.date.dayStr())\n\(e.date.timeStr()) - \(e.endDate.timeStr())\n\n\(e.desc)"
        alert.addButtonWithTitle("OK")
        alert.show()
    }

}

