//
//  RaffleManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/25/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import CoreData

let raffleMgr = RaffleManager()

class Raffle: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var date: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var localEntry: String
    var entries = [String]()
    var timeRemaining: String = { return "endDate - date" }()   //TODO: it
    
    func addEntry() -> String {
        var code = generateCode()
        
        // Save to Core Data
        localEntry = code
        coreDataHelper.saveData()
        
        // Push to Parse
        var query = PFQuery(className: "Raffle")
        query.whereKey("eventId", equalTo: id)
        
        query.getFirstObjectInBackgroundWithBlock{ event, error in
            if error == nil {
                event.addObject(self.localEntry, forKey: "entries")
                event.saveInBackgroundWithBlock{ void in }
            } else {
                println(error)
            }
        }
        
        return code
    }
    
    private func generateCode() -> String {
        let date = String(Int(NSDate().timeIntervalSince1970))
        let hash = date.md5() as NSString
        let code = hash.substringWithRange(NSRange(location: 0, length: 5)).uppercaseString
        return code
    }

}

class RaffleManager: ContentManager {
    init() {
        super.init(contentType: "Raffle")
    }
    
    override func populateList() {
        list = fetchStored()
        
        var query = PFQuery(className: "Raffle")
        query.findObjectsInBackgroundWithBlock { parseList, error in
        
            if let error = error {
                println("Could not retrieve raffles from Parse: \(error)")
            } else {
                // Only add to local storage if does not already exist
                for parseRaffle in parseList {
                    if self.getForID(parseRaffle["eventId"] as String) == nil {
                        // Add to Core Data
                        let newRaffle = NSEntityDescription.insertNewObjectForEntityForName("Raffle", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Raffle
                        
                        newRaffle.id = parseRaffle["eventId"] as String
                        newRaffle.date = parseRaffle["date"] as NSDate
                        newRaffle.endDate = parseRaffle["endDate"] as NSDate
                        newRaffle.localEntry = ""
                        
                        coreDataHelper.saveData()
                        
                        self.list.append(newRaffle)
                    }
                    
                    if let localRaffle = self.getForID(parseRaffle["eventId"] as String) {
                        localRaffle.entries = []
                        // Add all entries to localRaffle no matter what because they are not being stored w/ Core Data
                        if parseRaffle.allKeys.contains("entries") {
                            var entryCount = (parseRaffle["entries"] as [String]).count
                            localRaffle.entries = parseRaffle["entries"] as [String] // from parse
                        }
                    }

                }
                
                __eventsTableView!.reloadData()
            }
        }

    }
    
    func getForID(id: String) -> Raffle? {
        var result: Raffle? = nil
        
        for r in self.list {
            if (r as Raffle).id == id {
                result = r as? Raffle
            }
        }
        
        return result
    }
    
}