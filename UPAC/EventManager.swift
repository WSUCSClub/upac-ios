//
//  EventManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import CoreData

let eventMgr = EventManager()

class Event: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var image: String //TODO: Update to use NSURL
    @NSManaged var location: String
    @NSManaged var desc: String
    @NSManaged var date: NSDate
    @NSManaged var endDate: NSDate
}

class EventManager: ContentManager {
    init() {
        super.init(contentType: "Event")
    }
    
    override func populateList() {
        clearLocalStorage()
        
        //TODO: Populate events list using Facebook Graph API
        addEvent("134f21",
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
            endDate: NSDate())
    }
    
    func addEvent(id: String, name: String, image: String, location: String, desc: String, date: NSDate, endDate: NSDate) {
        let newEvent = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Event
        
        newEvent.id = id
        newEvent.name = name
        newEvent.image = image
        newEvent.location = location
        newEvent.desc = desc
        newEvent.date = date
        newEvent.endDate = endDate

    }
    
}