//
//  EventDetailViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/18/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet var image:UIImageView!
    @IBOutlet var name:UILabel!
    @IBOutlet var location:UILabel!
    @IBOutlet var date:UILabel!
    @IBOutlet var desc:UITextView!
    
    @IBOutlet var enterRaffleButton: UIButton!
    @IBOutlet var raffleCodeLabel: UILabel!
    
    var event:Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Raffle view
        if event.hasRaffle() {
            if raffleMgr.getForID(event.id)?.localEntry == "" {
                enterRaffleButton.hidden = false
            } else {
                raffleCodeLabel.hidden = false
                raffleCodeLabel.text = raffleMgr.getForID(event.id)?.localEntry
            }
            
            //show view
        }
        
        image.image = UIImage(named: event.image) //TODO: Update for URLs
        name.text = event.name
        location.text = event.location
        date.text = "\(event.date.dayStr()) @ \(event.date.timeStr()) - \(event.endDate.timeStr())"
        desc.text = event.desc
    }
    
    @IBAction func enterRaffleButtonTapped(sender: UIButton!) {
        // Add entry
        var entryCode = raffleMgr.getForID(event.id)?.addEntry()
        
        // Update view
        raffleCodeLabel.text = entryCode
        raffleCodeLabel.hidden = false
        enterRaffleButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
}
