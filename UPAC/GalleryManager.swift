//
//  GalleryManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

let galleryMgr = GalleryManager()

class Picture {
    var id   = String()
    var desc = String()
    var date = NSDate()
    var src  = String()
    var data = NSData()
}

class GalleryManager {
    var list = [Picture]()
    
    init() {
        list = getPictures()
    }
    
    func getPictures() -> [Picture] {
        var pictures = [Picture]()
        
        //TODO: Populate list using Facebook Graph API
        pictures.append(addPicture("oem291982",
            desc: "Lorem ipsum",
            date: NSDate(),
            src: "http://i.imgur.com/JM12Yfi.jpg"))
        pictures.append(addPicture("ldjf892jf8egrg",
            desc: "Dolor sit amet",
            date: NSDate(),
            src: "http://i.imgur.com/o2r9SRd.jpg"))
        pictures.append(addPicture("jfj320",
            desc: "Lorem ipsum",
            date: NSDate(),
            src: "http://i.imgur.com/HNGSjNO.jpg"))
        pictures.append(addPicture("0238jg",
            desc: "Dolor sit amet",
            date: NSDate(),
            src: "http://i.imgur.com/WDVsgVI.jpg"))
        pictures.append(addPicture("02989489jf",
            desc: "Lorem ipsum",
            date: NSDate(),
            src: "http://i.imgur.com/cdaeELR.jpg"))
        
        return pictures
    }
    
    func addPicture(id: String, desc: String, date: NSDate, src: String) -> Picture {
        let newPicture = Picture()
        
        newPicture.id = id
        newPicture.desc = desc
        newPicture.date = date
        newPicture.src = src
        
        dispatch_async(dispatch_get_main_queue()) {
        // getting background priority from global queue fails to load some pictures
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            if let data = NSData(contentsOfURL: NSURL(string:newPicture.src)!) {
                newPicture.data = data
            }
        }

        return newPicture
    }
    
}
