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
    var pictureData = NSData()
    
}

class BoardManager: ContentManager {
    var adminPrivileges = false
    
    init() {
        super.init(contentType: "Member")
    }
    
    override func populateList() {
        clearLocalStorage()     // Comment out for persistence
        list = fetchStored()
        
        var parseList = pullParseMembers()
        
        // Only add to local storage if does not already exist
        /*for member in parseList {
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
        }*/
        
        //dispatch_async(dispatch_get_main_queue()) {
            self.addMember("oij7tb",
                name: "Emily Meskan",
                position: "Director",
                email: "EMeskan11@winona.edu",
                picture: "http://www.winona.edu/upac/Images/UPAC-Emily_Meskan-profile.jpg")
            self.addMember("f65",
                name: "Brittany Bieber",
                position: "Assistant Director",
                email: "BBieber12@winona.edu",
                picture: "http://www.winona.edu/upac/Images/UPAC-Brittany_Bieber-profile.jpg")
            self.addMember("23424g4",
                name: "Megan Derke",
                position: "Accounts Director",
                email: "MDerke11@winona.edu",
                picture: "http://www.winona.edu/upac/Images/UPAC-Megan_Derke-profile.jpg")
            self.addMember("23g213r",
                name: "Chris Doffing",
                position: "Concerts Director",
                email: "CDoffing11@winona.edu",
                picture: "http://www.winona.edu/upac/Images/UPAC-Chris_Doffing-profile.jpg")
            self.addMember("bt2423",
                name: "Brooke Maher",
                position: "Special Events On-Campus Director",
                email: "BBieber12@winona.edu",
                picture: "http://www.winona.edu/upac/Images/UPAC-Brooke_Maher-profile.jpg")
        //}
        
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
        // Can only make one request at a time from winona.edu
        //TODO: don't fail if picture unavailable
        //TODO: get pictureData from Parse
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            newMember.pictureData = NSData(contentsOfURL: NSURL(string: newMember.picture)!)!
        }
        
        
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