//
//  BoardManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/1/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import CoreData

let boardMgr = BoardManager()

class Member: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var position: String
    @NSManaged var email: String
    @NSManaged var picture: String
    
}

class BoardManager: ContentManager {
    var adminPrivileges = false
    
    init() {
        super.init(contentType: "Member")
    }
    
    override func populateList() {
        //clearLocalStorage()     // Comment out for persistence
        list = fetchStored()
        
        var parseList = pullParseMembers()
        
        // Only add to local storage if does not already exist
        for member in parseList {
            var alreadyExists = false
            
            for localMember in list as [Member] {
                
                if member.id == localMember.id {
                    // Member already exists locally, don't add another
                    alreadyExists = true
                    break
                }
            }
            
            if !alreadyExists {
                addMember(member.id,
                    name: member.name,
                    position: member.position,
                    email: member.email,
                    picture: member.picture)
            }
        }
        
        /*addMember("oij7tb",
            name: "Emily Meskan",
            position: "Director",
            email: "EMeskan11@winona.edu",
            picture: "facebook")
        
        addMember("f65",
            name: "Brittany Bieber",
            position: "Assistant Director",
            email: "BBieber12@winona.edu",
            picture: "dirty dancing")*/
        
    }
    
    //TODO: it
    func pullParseMembers() -> [Member] {
        var parseMembers = list as [Member]
        
        return parseMembers
    }
    
    func addMember(id: String, name: String, position: String, email: String, picture: String) {
        let newMember = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Member
        
        newMember.id = id
        newMember.name = name
        newMember.position = position
        newMember.email = email
        newMember.picture = picture
        
        //TODO: push to parse
        
        coreDataHelper.saveData()
        list.append(newMember)
    }
    
    func deleteMember(member: Member) {
        coreDataHelper.managedObjectContext!.deleteObject(member)
        coreDataHelper.saveData()
        populateList()
        
        //TODO: push to parse
    }
    
}