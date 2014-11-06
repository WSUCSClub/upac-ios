//
//  EventManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import UIKit

let eventMgr = EventManager()

class Event {
    var id        = String()
    var name      = String()
    var location  = String()
    var desc      = String()
    var date      = NSDate()
    var endDate   = NSDate()
    var image     = String()
    var imageData = NSData()
    
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

class EventManager {
    var list = [Event]()
    
    init() {
        list = getEvents()
    }
    
    func getEvents() -> [Event] {
        var events = [Event]()
        // Uncomment and run once (then re-comment) if test data needed
        events.append(addEvent("134f21",
            name: "Dirty Dancing",
            image: "http://i.imgur.com/NTPbZQm.jpg",
            location: "Orpheum Theater - Minneapolis",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate()))
        events.append(addEvent("jf8929",
            name: "ValleyScare",
            image: "http://i.imgur.com/NMSHu3z.jpg",
            location: "ValleyFair - Shakopee",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate()))
        events.append(addEvent("klj298",
            name: "$3 Bowling Night",
            image: "http://i.imgur.com/eIviLU0.jpg",
            location: "Westgate Bowling Center",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate()))
        events.append(addEvent("owii8201",
            name: "Spin Magic",
            image: "http://www.spinmagic.net/uploads/2/8/3/8/2838440/3239161_orig.jpg",
            location: "Gazebo / SAC",
            desc: "Lorem ipsum dolor sit amet",
            date: NSDate(),
            endDate: NSDate()))
        
        for event in events {
            insertNotification(event)
        }
        
        return events
    }
    
    func insertNotification(event: Event) {
        let localNotification = UILocalNotification()
        
        localNotification.alertBody = "\(event.name) @ \(event.location)\n\(event.date)"
        localNotification.fireDate = event.date
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func addEvent(id: String, name: String, image: String, location: String, desc: String, date: NSDate, endDate: NSDate) -> Event {
        let newEvent = Event()
        newEvent.id = id
        newEvent.name = name
        newEvent.location = location
        newEvent.desc = desc
        newEvent.date = date
        newEvent.endDate = endDate
        
        newEvent.image = image
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            if let data = NSData(contentsOfURL: NSURL(string: newEvent.image)!) {
                newEvent.imageData = data
            }
        }
        
        return newEvent
    }
    
}