//
//  EventManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

//TODO: Add notifications for upcoming events

import Foundation

var eventMgr = EventManager();

//TODO: Add picture prop (:NSURL) if exists in FB API
struct Event {
    var title: String
    var location: String
    var description: String
    var startDate: NSDate
    var endDate: NSDate
}

class EventManager {
    
    var events = [Event]()
    
    init() {
        repopulateList()
    }
    
    func repopulateList() {
        //TODO: Populate events list using Facebook Graph API
        addEvent("Dirty Dancing",
            location: "Orpheum Theater - Minneapolis",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate())
        addEvent("ValleyScare",
            location: "ValleyFair - Shakopee",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate())
        addEvent("$3 Bowling Night",
            location: "Westgate Bowling Center",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate())
        addEvent("Spin Magic",
            location: "Gazebo / SAC",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate())
    }
    
    private func addEvent(title: String, location: String, description: String, startDate: NSDate, endDate: NSDate) {
        events.append(Event(title: title, location: location, description: description, startDate: startDate, endDate: endDate))
    }
    
}