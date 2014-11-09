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
        var accessToken = FBAccessTokenData.createTokenFromString("***REMOVED***",
            permissions: ["email"],
            expirationDate: nil,
            loginType: FBSessionLoginType.None,
            refreshDate: nil)
        
        FBSession.activeSession().closeAndClearTokenInformation()
        FBSession.activeSession().openFromAccessTokenData(accessToken) { session, result, error in }
        
        if FBSession.activeSession().isOpen {
            var pageRequest = FBRequest(graphPath: "322196472693/events", parameters: nil, HTTPMethod: nil)
            
            pageRequest.startWithCompletionHandler { connection, result, error in
                if FBSession.activeSession().isOpen {
                    println("error: \(error)")
                    println("result: \(result)")
                    
                    // Load Facebook events into list[] from json result
                    var data = result.objectForKey("data") as NSArray
                    for e in data {
                        let valueDic = e as NSDictionary
                        
                        let newEvent = self.addEvent(valueDic.objectForKey("id") as String,
                            name: (valueDic.objectForKey("name") as String).stringByReplacingOccurrencesOfString("UPAC Presents: ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil),
                            image: "http://i.imgur.com/NTPbZQm.jpg",
                            location: valueDic.objectForKey("location") as String,
                            desc: "Lorem ipsum dolor sit amet",
                            date: NSDate(),
                            endDate: NSDate())
                        
                        self.insertNotification(newEvent)
                        self.list.append(newEvent)
                    }
                    
                    __eventsTableView!.reloadData()
                    
                }
            }
        }
    }
    
    func insertNotification(event: Event) {
        let localNotification = UILocalNotification()
        
        localNotification.alertBody = "\(event.name) @ \(event.location)\n\(event.date)"
        
        var alertTime = NSTimeInterval(-3600)   // 1 hour prior
        localNotification.fireDate = NSDate(timeInterval: alertTime, sinceDate: event.date)
        
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