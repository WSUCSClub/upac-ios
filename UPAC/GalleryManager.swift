//
//  GalleryManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import CoreData

let galleryMgr = GalleryManager()

class Picture: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var desc: String
    @NSManaged var date: NSDate
    @NSManaged var url: String
    @NSManaged var src: String
}

class GalleryManager: ContentManager {
    init() {
        super.init(contentType: "Picture")
    }
    
    override func populateList() {
        clearLocalStorage()
        
        //TODO: Populate list using Facebook Graph API
        addPicture("oem291982",
            desc: "Lorem ipsum",
            date: NSDate(),
            url: "http://google.com",
            src: "scare")
        addPicture("ldjf892jf8egrg",
            desc: "Dolor sit amet",
            date: NSDate(),
            url: "http://yahoo.com",
            src: "spin")
        addPicture("jfj320",
            desc: "Lorem ipsum",
            date: NSDate(),
            url: "http://google.com",
            src: "spin")
        addPicture("0238jg",
            desc: "Dolor sit amet",
            date: NSDate(),
            url: "http://yahoo.com",
            src: "scare")
        addPicture("02989489jf",
            desc: "Lorem ipsum",
            date: NSDate(),
            url: "http://yahoo.com",
            src: "scare")
    }
    
    func pullFacebookPictures() -> [Picture] {
        var fbPictures = [Picture]()
        
        return fbPictures
    }
    
    func addPicture(id: String, desc: String, date: NSDate, url: String, src: String) {
        let newPicture = NSEntityDescription.insertNewObjectForEntityForName("Picture", inManagedObjectContext: coreDataHelper.managedObjectContext!) as Picture
        
        newPicture.id = id
        newPicture.desc = desc
        newPicture.date = date
        newPicture.url = url
        newPicture.src = src
    }
    
}
