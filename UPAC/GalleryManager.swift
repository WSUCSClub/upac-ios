//
//  GalleryManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

var galleryMgr = GalleryManager();

struct Picture {
    var id: String
    var description: String
    var date: NSDate
    var url: NSURL
    var src: String
}

class GalleryManager {
    
    var pics = [Picture]()
    
    init() {
        repopulateList()
    }
    
    func repopulateList() {
        pics.removeAll(keepCapacity: false)
        
        //TODO: Populate list using Facebook Graph API
        addPicture("oem291982",
            description: "Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            src: "spin")
        addPicture("ldjf892jf8egrg",
            description: "Dolor sit amet",
            date: NSDate(),
            url: NSURL(string: "http://yahoo.com"),
            src: "spin")
        addPicture("jfj320",
            description: "Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            src: "spin")
        addPicture("0238jg",
            description: "Dolor sit amet",
            date: NSDate(),
            url: NSURL(string: "http://yahoo.com"),
            src: "scare")
        addPicture("02989489jf",
            description: "Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            src: "scare")
    }
    
    private func addPicture(id: String, description: String, date: NSDate, url: NSURL, src: String) {
        pics.append(Picture(id: id, description: description, date: date, url: url, src: src))
    }
    
}