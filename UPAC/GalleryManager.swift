//
//  GalleryManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/11/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

var galleryMgr = GalleryManager();

struct Pic {
    var description: String
    var date: NSDate
    var url: NSURL
    var img: String
}

class GalleryManager {
    
    var pics = [Pic]()    
    
    init() {
        repopulateList()
    }
    
    func repopulateList() {
        //TODO: Populate list using Facebook Graph API
        addPic("Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            img: "icon")
        addPic("Dolor sit amet",
            date: NSDate(),
            url: NSURL(string: "http://yahoo.com"),
            img: "second")
        addPic("Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            img: "first")
        addPic("Dolor sit amet",
            date: NSDate(),
            url: NSURL(string: "http://yahoo.com"),
            img: "second")
        addPic("Lorem ipsum",
            date: NSDate(),
            url: NSURL(string: "http://google.com"),
            img: "first")
    }
    
    private func addPic(description: String, date: NSDate, url: NSURL, img: String) {
        pics.append(Pic(description: description, date: date, url: url, img: img))
    }
    
}