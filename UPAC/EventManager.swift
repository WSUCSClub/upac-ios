//
//  EventManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let eventMgr = EventManager()

class Event: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var image: String //TODO: Update to use NSURL
    @NSManaged var location: String
    @NSManaged var desc: String
    @NSManaged var date: NSDate
    @NSManaged var endDate: NSDate
    
    func hasRaffle() -> Bool {
        var result = false
        
        for r in raffleMgr.list {
            if (r as Raffle).id == self.id {
                result = true
                break
            }
        }
        
        return result
    }
}

class EventManager: ContentManager {    
    init() {
        super.init(contentType: "Event")
    }
    
    override func populateList() {
        //clearLocalStorage()
        
        list = fetchStored()
        
        var FBList = list    //TODO: Populate using FB Graph API
        
        // Only add to local storage if does not already exist
        for event in FBList as [Event] {
            var alreadyExists = false
            
            for localEvent in list as [Event] {
                if event.id == localEvent.id {
                    // Event already exists locally, don't add another
                    alreadyExists = true
                    break
                }
            }
            
            if !alreadyExists {
                addEvent(event.id,
                    name: event.name,
                    image: event.image,
                    location: event.location,
                    desc: event.desc,
                    date: event.date,
                    endDate: event.endDate)
            }
        }
        
        // Uncomment and run once (then re-comment) if test data needed
        /*addEvent("134f21",
            name: "Dirty Dancing",
            image: "spin",
            location: "Orpheum Theater - Minneapolis",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate())
        addEvent("jf8929",
            name: "ValleyScare",
            image: "scare",
            location: "ValleyFair - Shakopee",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate())
        addEvent("klj298",
            name: "$3 Bowling Night",
            image: "scare",
            location: "Westgate Bowling Center",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate())
        addEvent("owii8201",
            name: "Spin Magic",
            image: "spin",
            location: "Gazebo / SAC",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate())*/
    }
    
    func addEvent(id: String, name: String, image: String, location: String, desc: String, date: NSDate, endDate: NSDate) {
        // Add to Core Data
        let newEvent = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Event
        newEvent.id = id
        newEvent.name = name
        newEvent.image = image
        newEvent.location = location
        newEvent.desc = desc
        newEvent.date = date
        newEvent.endDate = endDate
        
        // Insert notification
        var localNotification = UILocalNotification()
        localNotification.alertBody = "\(name) @ \(location)\n\(date)"
        localNotification.fireDate = date
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
}