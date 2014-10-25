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
    var timeRemaining: String = { return "endDate - date" }()
}

class RaffleManager: ContentManager {
    init() {
        super.init(contentType: "Raffle")
    }
    
    override func populateList() {
        //TODO: Populate events list using Facebook Graph API
        addRaffle("134f21",
            date: NSDate(),
            endDate: NSDate())
        addRaffle("jf8929",
            date: NSDate(),
            endDate: NSDate())
        addRaffle("owii8201",
            date: NSDate(),
            endDate: NSDate())
    }
    
    func addRaffle(id: String, date: NSDate, endDate: NSDate) {
        let newRaffle = NSEntityDescription.insertNewObjectForEntityForName("Raffle", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Raffle
        
        //store locally
        //update localEntry
        //push to parse
        
        newRaffle.id = id
        newRaffle.date = date
        newRaffle.endDate = endDate
        newRaffle.localEntry = generateCode()
        
    }
    
    //TODO: implement
    private func generateCode() -> String {
        return String(Int(NSDate().timeIntervalSince1970))
    }
    
    //TODO: implement
    private func findTimeRemaining(date: NSDate, endDate:NSDate) -> String {
        return "endDate - date"
    }
    
}