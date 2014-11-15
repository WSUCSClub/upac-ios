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
        list = []
        populateList()
    }
    
    func populateList() {
        //TODO: pull from Parse
    }
    
    func addMember(name: String, position: String, email: String, picture: NSData) {
        let newMember = Member()
        
        newMember.name = name
        newMember.position = position
        newMember.email = email
        newMember.picture = picture
        
        list.append(newMember)
        
        // Add to Parse
        var parseMember = PFObject(className: "Member")
        
        parseMember["name"] = newMember.name
        parseMember["position"] = newMember.position
        parseMember["email"] = newMember.email
        
        parseMember.saveInBackgroundWithBlock { success, error in
            if !success {
                println(error)
            } else {
                var pictureFile = PFFile(name: "\(newMember.name).jpg", data: newMember.picture)
                pictureFile.saveInBackgroundWithBlock { success, error in
                    if error == nil {
                        parseMember["picture"] = pictureFile
                        parseMember.saveInBackgroundWithBlock { sucess, error in
                            println("saved image")
                        }
                    } else {
                        println(error)
                    }
                }
            }
        }
        
    }
    
    func deleteMember(member: Member) {
        //TODO: remove member from parse
        
        populateList()
    }
    
}