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
        
        localEntry = code
        coreDataHelper.saveData()
        
        //TODO: push to parse
        
        return code
    }
    
    func drawWinners(numberOfWinners: Int) -> [String] {
        var winners = [String]()
        
        var i = 0
        while i < numberOfWinners && i < entries.count {
            ++i
            
            if entries.count < 1 {
                break
            }
            
            var random = Int(arc4random()) % entries.count
            var possibleWinner = entries[random]
            
            // Make sure entry isn't already a winner
            var alreadyWon = false
            for winner in winners {
                if possibleWinner == winner {
                    alreadyWon = true
                    --i
                    break
                }
            }
            
            if !alreadyWon {
                winners.append(possibleWinner)
            }
        }
        
        return winners
    }
    
    //TODO: pull from parse
    func getEntries() {
        entries.append("asldk")
        entries.append("49tgl")
    }
    
    //TODO: implement (5 char alpha-numeric)
    private func generateCode() -> String {
        return String(Int(NSDate().timeIntervalSince1970))
    }

}

class RaffleManager: ContentManager {
    var adminPrivileges = false
    
    init() {
        super.init(contentType: "Raffle")
    }
    
    override func populateList() {
        //clearLocalStorage()     // Comment out for persistence
        list = fetchStored()
        
        var parseList = pullParseRaffles()
        
        // Only add to local storage if does not already exist
        for raffle in parseList {
            var alreadyExists = false
            
            for localRaffle in list as [Raffle] {
                localRaffle.entries = []
                //TODO: add all entries to localRaffle no matter what because they are not being stored w/ Core Data
                // localRaffle.entries = raffle.entries // from parse
                localRaffle.getEntries()
                
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

    }
    
    //TODO: it
    func pullParseRaffles() -> [Raffle] {
        var parseRaffles = list as [Raffle]
        
        return parseRaffles
    }
    
    func addRaffle(id: String, date: NSDate, endDate: NSDate) {
        let newRaffle = NSEntityDescription.insertNewObjectForEntityForName("Raffle", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Raffle
        
        newRaffle.id = id
        newRaffle.date = date
        newRaffle.endDate = endDate
        newRaffle.localEntry = ""
        
        //TODO: push to parse
        
        coreDataHelper.saveData()
        list.append(newRaffle)
    }
    
    func deleteRaffle(raffle: Raffle) {
        coreDataHelper.managedObjectContext!.deleteObject(raffle)
        coreDataHelper.saveData()
        populateList()
        
        //TODO: push to parse
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