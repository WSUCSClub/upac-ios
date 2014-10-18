//
//  Raffle.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/17/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

//TODO: implement
import Foundation

struct Entry {
    var code = Int()
    
    init() {
        code = generateCode()
    }

    func generateCode() -> Int {
        //generate random code
        return 1
    }
}

class Raffle {
    var entries = [Entry]()
    var startTime = NSDate()
    var endTime = NSDate()
    
    init() {
        //
    }
    
    func addEntry(entry:Entry) {
        //generate code
        //push to parse
    }
    
    func generateCode() {
        // generate a unique code
    }
    
    func pickWinner() {
        //pull entries from parse
        //pick entry from list
    }
    
    func timeRemaining() -> String{
        return "endTime - startTime"
    }
}