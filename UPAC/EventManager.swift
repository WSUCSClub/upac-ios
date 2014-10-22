//
//  EventManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

var eventMgr = EventManager();

struct Event {
    var id: String
    var name: String
    var image: String //TODO: Update to use NSURL
    var location: String
    var description: String
    var startDate: NSDate
    var endDate: NSDate
    var raffle: Raffle?
}

class EventManager {
    var events = [Event]()
    
    init() {
        repopulateList()
    }
    
    func repopulateList() {
        events = []

        //TODO: Populate events list using Facebook Graph API
        addEvent("134f21",
            name: "Dirty Dancing",
            image: "spin",
            location: "Orpheum Theater - Minneapolis",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate(),
            raffle: Raffle(startTime: NSDate(), endTime: NSDate()))
        addEvent("jf8929",
            name: "ValleyScare",
            image: "scare",
            location: "ValleyFair - Shakopee",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate(),
            raffle: Raffle(startTime: NSDate(), endTime: NSDate()))
        addEvent("klj298",
            name: "$3 Bowling Night",
            image: "scare",
            location: "Westgate Bowling Center",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate(),
            raffle: Raffle(startTime: NSDate(), endTime: NSDate()))
        addEvent("owii8201",
            name: "Spin Magic",
            image: "spin",
            location: "Gazebo / SAC",
            description: "Lorem ipsum dolor sit amet",
            startDate: NSDate(),
            endDate: NSDate(),
            raffle: Raffle(startTime: NSDate(), endTime: NSDate()))
    }
    
    private func addEvent(id: String, name: String, image: String, location: String, description: String, startDate: NSDate, endDate: NSDate, raffle: Raffle) {
        events.append(Event(id: id, name: name, image: image, location: location, description: description, startDate: startDate, endDate: endDate, raffle: raffle))
    }
    
}