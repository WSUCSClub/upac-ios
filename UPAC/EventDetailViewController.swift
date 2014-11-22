//
//  EventDetailViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/18/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    @IBOutlet var imageContainerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var desc: UITextView!
    
    @IBOutlet var enterRaffleButton: UIButton!
    @IBOutlet var raffleCodeLabel: UILabel!
    
    @IBOutlet var raffleDateLabel: UILabel!
    
    @IBOutlet var createRaffleButton: UIButton!
    @IBOutlet var deleteRaffleButton: UIButton!
    @IBOutlet var drawWinnersButton: UIButton!
    @IBOutlet var numberOfParticipantsLabel: UILabel!
    
    @IBOutlet var raffleBar: UIImageView!
    
    var event: Event!
    var raffle: Raffle?
    var index: Int!
    var delegate: EventsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if event.hasRaffle() {
            raffle = raffleMgr.getForID(event.id)?
        }
        
        updateView()
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("moveToNextEvent"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("moveToPreviousEvent"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func updateView() {
        self.navigationItem.title = event.name

        // Raffle view
        if event.hasRaffle() && raffleMgr.adminPrivileges {
            raffleBar.hidden = false
            raffleDateLabel.hidden = false
            raffleDateLabel.text = "\(raffle!.date.timeStr()) - \(raffle!.endDate.timeStr())"
        } else {
            raffleBar.hidden = true
            raffleDateLabel.hidden = true
        }
        
        if event.hasRaffle() && !raffleMgr.adminPrivileges {
            if raffleMgr.getForID(event.id)?.localEntry == "" {
                //TODO: only show "Enter raffle" button if at event location
                // Only show "Enter raffle" button if raffle is still open
                if raffleMgr.getForID(event.id)?.endDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    enterRaffleButton.hidden = false
                }
                raffleCodeLabel.hidden = true
            } else {
                enterRaffleButton.hidden = true
                raffleCodeLabel.hidden = false
                raffleCodeLabel.text = "Ticket #\((raffleMgr.getForID(event.id)?.localEntry)!)"
            }
            
            deleteRaffleButton.hidden = true
        } else if !event.hasRaffle() && !raffleMgr.adminPrivileges {
            enterRaffleButton.hidden = true
            raffleCodeLabel.hidden = true
            deleteRaffleButton.hidden = true
        } else if event.hasRaffle() && raffleMgr.adminPrivileges {
            createRaffleButton.hidden = true
            deleteRaffleButton.hidden = false
            
            drawWinnersButton.hidden = false
            
            numberOfParticipantsLabel.hidden = false
            numberOfParticipantsLabel.text = String(raffleMgr.getForID(event.id)!.entries.count)
        } else if !event.hasRaffle() && raffleMgr.adminPrivileges {
            createRaffleButton.hidden = false
            deleteRaffleButton.hidden = true
            drawWinnersButton.hidden = true
            numberOfParticipantsLabel.hidden = true
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.image.image = UIImage(data: self.event.imageData)
        }
        
        contentView.layer.borderColor = UIColor(rgb: 0xCCCCCC).CGColor
        imageContainerView.layer.borderColor = UIColor(rgb: 0xCCCCCC).CGColor
        name.text = event.name
        location.text = event.location
        date.text = "\(event.date.dayStr()) @ \(event.date.timeStr())"
        
        // Only show end date if it is not the same as the start
        if event.date != event.endDate {
            date.text = "\(date.text!) - \(event.endDate.timeStr())"
        }
        desc.text = event.desc
        
        //TODO: set map view to event.location
    }
    
    @IBAction func enterRaffleButtonTapped(sender: UIButton!) {
        // Add entry
        var entryCode = raffleMgr.getForID(event.id)?.addEntry()
        
        // Update view
        raffleCodeLabel.text = "Ticket #\(entryCode!)"
        raffleCodeLabel.hidden = false
        enterRaffleButton.hidden = true
    }
    
    @IBAction func drawWinnersButtonTapped(sender: UIButton!) {
        var winners = [String]()
        var pickWinnersAlert = UIAlertController(title: "", message: "How many winners will there be?", preferredStyle: .Alert)
        
        var inputNumberField = UITextField()
        pickWinnersAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "#"
            inputNumberField = textField
        }
        pickWinnersAlert.view.tintColor = UIColor.blueColor()
        
        var cancel = UIAlertAction(title: "Cancel", style: .Default) { (action) -> Void in }
        pickWinnersAlert.addAction(cancel)
        
        var ok = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            var number: Int? = inputNumberField.text.toInt()
            
            if let number = number {     // Validating input
                winners = raffleMgr.getForID(self.event.id)!.drawWinners(number)
                
                var showWinnersAlert = UIAlertController(title: "Winners", message: "", preferredStyle: .Alert)
                showWinnersAlert.view.tintColor = UIColor.blueColor()
                
                for w in winners {
                    showWinnersAlert.message! += "\(w)\n"
                }
                
                var dismiss = UIAlertAction(title: "Got 'em!", style: .Default) { (action) -> Void in }
                showWinnersAlert.addAction(dismiss)
                
                // Need to wrap presentation to prevent warning
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(showWinnersAlert, animated: true, completion: nil)
                }
            }
            
        }
        pickWinnersAlert.addAction(ok)
        
        // Need to wrap presentation to prevent warning
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(pickWinnersAlert, animated: true, completion: nil)
        }

    }
    
    @IBAction func deleteRaffleButtonTapped(sender: UIButton!) {
        raffleMgr.deleteRaffle(raffle!)
        
        updateView()
    }
    
    func moveToNextEvent() {
        if index + 1 < eventMgr.list.count {
            index?++
            event = eventMgr.list[index] as Event
            raffle = raffleMgr.getForID(event.id)?
            
            updateView()
        }
    }
    
    func moveToPreviousEvent() {
        if index - 1 >= 0 {
            index?--
            event = eventMgr.list[index] as Event
            raffle = raffleMgr.getForID(event.id)?
            
            updateView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NewRaffleView") {
            let destinationView: NewRaffleViewController = segue.destinationViewController as NewRaffleViewController
            
            destinationView.delegate = self
            destinationView.event = event
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.delegate.tableView.reloadData()
        })
    }
}
