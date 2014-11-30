//
//  EventDetailViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/18/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet var topHeightConstraint: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var imageContainerView: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var desc: UITextView!
    @IBOutlet var descHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var notifyButton: UIButton!
    @IBOutlet var dontNotifyButton: UIButton!
    
    @IBOutlet var enterRaffleButton: UIButton!
    @IBOutlet var raffleCodeLabel: UILabel!
    
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

        // Only show notification buttons if event hasn't happened yet and have permission
        if event.date.compare(NSDate()) == .OrderedDescending && UIApplication.sharedApplication().currentUserNotificationSettings().types != .None {
            if event.hasNotification() {
                notifyButton.hidden = true
                dontNotifyButton.hidden = false
            } else {
                notifyButton.hidden = false
                dontNotifyButton.hidden = false
            }
        } else {
            notifyButton.hidden = true
            dontNotifyButton.hidden = true
        }
        
        if event.hasRaffle() {
            // Onboarding
            //NSUserDefaults.standardUserDefaults().removeObjectForKey("firstRun")
            if NSUserDefaults.standardUserDefaults().objectForKey("firstRun") == nil {
                var onboardingTitle = "How Raffles Work"
                var onboardingMessage = "\nJust click the \"Enter Raffle\" button to enter this event's raffle for a chance to win a prize, then during the event UPAC will announce the winners. Did we mention it's absolutely free?!"
                
                var alert = UIAlertController(title: onboardingTitle, message: onboardingMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                alert.view.tintColor = UIColor.blueColor()
                self.presentViewController(alert, animated: true, completion: nil)
                
                NSUserDefaults.standardUserDefaults().setObject(false, forKey: "firstRun")
            }
            
            
            if raffleMgr.getForID(event.id)?.localEntry == "" {
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
        } else {
            enterRaffleButton.hidden = true
            raffleCodeLabel.hidden = true
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.image.image = UIImage(data: self.event.imageData)
        }
        
        imageContainerView.layer.borderColor = UIColor(rgb: 0xCCCCCC).CGColor
        name.text = event.name
        location.text = event.location
        date.text = "\(event.date.dayStr()) @ \(event.date.timeStr())"
        
        // Only show end date if it is not the same as the start
        if event.date != event.endDate {
            date.text = "\(date.text!) - \(event.endDate.timeStr())"
        }
        
        desc.text = event.desc
        descHeightConstraint.constant = desc.sizeThatFits(CGSize(width: desc.frame.width, height: CGFloat.max)).height
        
        scrollView.setContentOffset(CGPointMake(0, topHeightConstraint.constant), animated: false)


    }
    
    @IBAction func enterRaffleButtonTapped(sender: UIButton!) {
        // Add entry
        var entryCode = raffleMgr.getForID(event.id)?.addEntry()
        
        // Update view
        raffleCodeLabel.text = "Ticket #\(entryCode!)"
        raffleCodeLabel.hidden = false
        enterRaffleButton.hidden = true
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton!) {
        event.addNotification()
        
        notifyButton.hidden = true
        dontNotifyButton.hidden = false
    }
    
    
    @IBAction func dontNotifyButtonTapped(sender: UIButton!) {
        event.removeNotification()
        
        notifyButton.hidden = false
        dontNotifyButton.hidden = true
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
    
    override func viewDidDisappear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.delegate.tableView.reloadData()
        })
    }
}
