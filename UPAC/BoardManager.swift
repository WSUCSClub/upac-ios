//
//  BoardManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/1/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

let boardMgr = BoardManager()

class Member {
    var id          = String()
    var name        = String()
    var position    = String()
    var email       = String()
    var picture     = NSData()
    
}

class BoardManager {
    var list = [Member]()
    
    init() {
        populateList()
    }
    
    func populateList() {
        list = []
        
        var query = PFQuery(className: "Member")
        query.findObjectsInBackgroundWithBlock { parseList, error in
            if let error = error {
                println("Could not retrieve board members from Parse: \(error)")
            } else {
                for parseMember in parseList {
                    let newMember = Member()
                    
                    newMember.name = parseMember["name"] as String
                    newMember.position = parseMember["position"] as String
                    newMember.email = parseMember["email"] as String
                    newMember.picture = (parseMember["picture"] as PFFile).getData()
                    
                    self.list.append(newMember)
                }
                
                __boardTableView!.reloadData()
            }
        }
    }
        
}