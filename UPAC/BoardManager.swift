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
    var picture     = String()
    var pictureData = NSData()
    
}

class BoardManager {
    var list = [Member]()
    
    init() {
        list = getMembers()
    }
    
    func getMembers() -> [Member] {
        var members = [Member]()
        
        members.append(addMember("oij7tb",
            name: "Emily Meskan",
            position: "Director",
            email: "EMeskan11@winona.edu",
            picture: "http://www.winona.edu/upac/Images/UPAC-Emily_Meskan-profile.jpg"))
        members.append(addMember("f65",
            name: "Brittany Bieber",
            position: "Assistant Director",
            email: "BBieber12@winona.edu",
            picture: "http://www.winona.edu/upac/Images/UPAC-Brittany_Bieber-profile.jpg"))
        members.append(addMember("23424g4",
            name: "Megan Derke",
            position: "Accounts Director",
            email: "MDerke11@winona.edu",
            picture: "http://www.winona.edu/upac/Images/UPAC-Megan_Derke-profile.jpg"))
        members.append(addMember("23g213r",
            name: "Chris Doffing",
            position: "Concerts Director",
            email: "CDoffing11@winona.edu",
            picture: "http://www.winona.edu/upac/Images/UPAC-Chris_Doffing-profile.jpg"))
        members.append(addMember("bt2423",
            name: "Brooke Maher",
            position: "Special Events On-Campus Director",
            email: "BBieber12@winona.edu",
            picture: "http://www.winona.edu/upac/Images/UPAC-Brooke_Maher-profile.jpg"))
        
        return members
    }
    
    func addMember(id: String, name: String, position: String, email: String, picture: String) -> Member {
        let newMember = Member()
        
        newMember.id = id
        newMember.name = name
        newMember.position = position
        newMember.email = email
        
        newMember.picture = picture
        // Can only make one request at a time from winona.edu
        //TODO: get pictureData from Parse
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            if let data = NSData(contentsOfURL: NSURL(string: newMember.picture)!) {
                newMember.pictureData = data
            }
        }
        
        //TODO: push to parse
        
        return newMember
    }
    
    func deleteMember(member: Member) {
        //TODO: remove member from parse
        
        list = getMembers()
    }
    
}