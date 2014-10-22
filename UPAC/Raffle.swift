//
//  Raffle.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/17/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

struct Entry {
    var code = Double()
    
    init() {
        code = generateCode()
    }

    func generateCode() -> Double {
        //TODO: generate RANDOM code
        return NSDate().timeIntervalSince1970
    }
}

class Raffle {
    var startTime: NSDate
    var endTime: NSDate
    var timeRemaining = String()
    
    init(startTime: NSDate, endTime:NSDate) {
        self.startTime = startTime
        self.endTime = endTime
        
        timeRemaining = findTimeRemaining(startTime, endTime: endTime)
    }
    
    func addEntry() -> Entry {
        var entry = Entry()
        
        //push to parse
        
        return entry
    }
    
    //TODO: implement
    private func findTimeRemaining(startTime: NSDate, endTime:NSDate) -> String{
        return "endTime - startTime"
    }
}
