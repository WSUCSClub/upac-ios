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
    
    var event:Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage(named: event.image) //TODO: Update for URLs
        name.text = event.name
        location.text = event.location
        date.text = "\(event.startDate.dayStr()) @ \(event.startDate.timeStr()) - \(event.endDate.timeStr())"
        desc.text = event.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
}
