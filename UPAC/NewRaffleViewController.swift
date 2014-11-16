//
//  NewRaffleViewController.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/28/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

class NewRaffleViewController: UIViewController {
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    var event: Event!
    var delegate: EventDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveRaffle() {
        var startDate = startDatePicker.date
        var endDate = endDatePicker.date
                
        raffleMgr.addRaffle(event.id, date: startDate, endDate: endDate)
        delegate.raffle = raffleMgr.getForID(event.id)?
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        saveRaffle()
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    
    override func viewDidDisappear(animated: Bool) {
        delegate.updateView()
    }
    
}
