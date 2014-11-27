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

class RaffleManager {
    var list = [Raffle]()

    init() {
        getRaffles()
    }
    
    func fetchStored() -> [Raffle] {
        let fetchRequest = NSFetchRequest(entityName: "Raffle")
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [ sortDescriptor ]
        
        return coreDataHelper.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as [Raffle]!
    }
    
    func getRaffles() {
        list = fetchStored()
        
        var query = PFQuery(className: "Raffle")
        query.findObjectsInBackgroundWithBlock { parseList, error in
        
            if let error = error {
                println("Could not retrieve raffles from Parse: \(error)")
            } else {
                
                // Delete local raffle if it no longer exists in Parse
                for localRaffle in self.list {
                    var stillExists = false
                    
                    for parseRaffle in parseList {
                        if localRaffle.id == parseRaffle["eventId"] as String {
                            stillExists = true
                        }
                    }
                    
                    if !stillExists {
                        coreDataHelper.managedObjectContext!.deleteObject(localRaffle)
                        coreDataHelper.saveData()
                        self.list = self.fetchStored()
                    }
                }
                
                // Only add to local storage if does not already exist
                for parseRaffle in parseList {
                    if self.getForID(parseRaffle["eventId"] as String) == nil {
                        // Add to Core Data
                        let newRaffle = NSEntityDescription.insertNewObjectForEntityForName("Raffle", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Raffle
                        
                        newRaffle.id = parseRaffle["eventId"] as String
                        newRaffle.date = parseRaffle["date"] as NSDate
                        newRaffle.endDate = parseRaffle["endDate"] as NSDate
                        newRaffle.localEntry = ""
                        
                        self.list.append(newRaffle)
                    }

                }
                
                coreDataHelper.saveData()
                __eventsTableView!.reloadData()
            }
        }

    }
    
    func getForID(id: String) -> Raffle? {
        var result: Raffle? = nil
        
        for r in self.list {
            if (r).id == id {
                result = r
            }
        }
        
        return result
    }
    
}