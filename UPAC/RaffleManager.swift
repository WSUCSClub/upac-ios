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
        
        localEntry = code
        //coreDataHelper.saveData()     // Uncomment to save raffle entries
        
        //TODO: push to parse
        
        return code
    }
    
    //TODO: implement (5 char alpha-numeric)
    private func generateCode() -> String {
        return String(Int(NSDate().timeIntervalSince1970))
    }

}

class RaffleManager: ContentManager {
    init() {
        super.init(contentType: "Raffle")
    }
    
    override func populateList() {
        //clearLocalStorage()
        list = fetchStored()
        
        var parseList = list    //TODO: Populate with Parse data
        
        // Only add to local storage if does not already exist
        for raffle in parseList as [Raffle] {
            var alreadyExists = false
            
            for localRaffle in list as [Raffle] {
                if raffle.id == localRaffle.id {
                    // Raffle already exists locally, don't add another
                    alreadyExists = true
                    break
                }
            }
            
            if !alreadyExists {
                addRaffle(raffle.id, date: raffle.date, endDate: raffle.endDate)
            }
        }
        
        // Uncomment and run once (then re-comment) if test data needed
        /*addRaffle("134f21",
            date: NSDate(),
            endDate: NSDate())
        addRaffle("owii8201",
            date: NSDate(),
            endDate: NSDate())*/
    }
    
    func addRaffle(id: String, date: NSDate, endDate: NSDate) {
        let newRaffle = NSEntityDescription.insertNewObjectForEntityForName("Raffle", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Raffle
        
        newRaffle.id = id
        newRaffle.date = date
        newRaffle.endDate = endDate
        newRaffle.localEntry = ""
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