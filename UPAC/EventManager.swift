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
        getFBEvents()
    }
    
    func getFBEvents() {
        if FBSession.activeSession().isOpen {
            var twoMonthsAgo = NSDate(timeIntervalSinceNow: NSTimeInterval(-5000000))
            var eventListRequest = FBRequest(graphPath: "322196472693/events", parameters: ["since":"\(twoMonthsAgo)"], HTTPMethod: nil)
            
            eventListRequest.startWithCompletionHandler { connection, listResult, listError in
                // Load Facebook event IDs  from json result
                var eventIDs = [String]()
                for eventDic in listResult.objectForKey("data") as [[String : String]] {
                    eventIDs.append(eventDic["id"]!)
                }
                
                // Load Facebook events into list[] from json result
                var eventsLoaded = 0
                for eventID in eventIDs {
                    var eventRequest = FBRequest(graphPath: eventID, parameters: ["fields":"id,name,cover,location,description,start_time,end_time"], HTTPMethod: nil)
                    
                    eventRequest.startWithCompletionHandler { connection, eventResult, eventError in                        
                        let event = eventResult as [String : AnyObject]
                        
                        // Convert timestamps to NSDate
                        let startTimestamp = event["start_time"]! as String
                        
                        // Events do not have to have a set end_time
                        var endTimestamp: String
                        if event["end_time"] != nil {
                            endTimestamp = event["end_time"]! as String
                        } else {
                            endTimestamp = startTimestamp
                        }
                        
                        
                        let newEvent = self.addEvent(event["id"]! as String,
                            name: (event["name"]! as String).stringByReplacingOccurrencesOfString("UPAC Presents: ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil),
                            image: (event["cover"]! as NSDictionary).valueForKey("source") as String,
                            location: event["location"]! as String,
                            desc: event["description"]! as String,
                            date: NSDate.fromFBDate(startTimestamp),
                            endDate: NSDate.fromFBDate(endTimestamp))
                        
                        self.insertNotification(newEvent)
                        self.list.append(newEvent)
                        
                        // Once all the events have been loaded
                        if ++eventsLoaded == eventIDs.count {
                            // Sort list by date
                            self.list.sort({$0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow})
                            
                            // Refresh tableView
                            __eventsTableView!.reloadData()
                        }

                    }
                }
            }
        }
    }
    
    func insertNotification(event: Event) {
        let localNotification = UILocalNotification()
        
        localNotification.alertBody = "\(event.name) @ \(event.location)\n\(event.date)"
        
        //TODO: get alert time from settings
        var alertTime = NSTimeInterval(-3600)   // 1 hour prior
        localNotification.fireDate = NSDate(timeInterval: alertTime, sinceDate: event.date)
        
        if UIApplication.sharedApplication().currentUserNotificationSettings().types != .None {
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
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