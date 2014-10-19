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
    var id: Int
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
        //TODO: Populate list using Facebook Graph API
        addPicture("Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            src: "spin")
        addPicture("Dolor sit amet",
            date: NSDate(),
            url: NSURL(string: "http://yahoo.com"),
            src: "spin")
        addPicture("Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            src: "spin")
        addPicture("Dolor sit amet",
            date: NSDate(),
            url: NSURL(string: "http://yahoo.com"),
            src: "scare")
        addPicture("Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            src: "scare")
    }
    
    private func addPicture(description: String, date: NSDate, url: NSURL, src: String) {
        pics.append(Picture(id: pics.count, description: description, date: date, url: url, src: src))
    }
    
}