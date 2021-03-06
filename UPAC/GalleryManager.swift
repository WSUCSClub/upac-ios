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
    var id    = String()
    var date  = NSDate()
    var thumb = String()
    var src   = String()
    var data  = NSData()
}

class GalleryManager {
    var list = [[Picture]]()
    
    init() {
        getFBPictures()
    }
    
    func getFBPictures() {
        getFBPictures() { void in }
    }
    
    //TODO: get only most recent photos; refresh __galleryCollectionView at the correct time
    func getFBPictures(finishedLoadingClosure: () -> Void) {
        list = []
        
        if FBSession.activeSession().isOpen {
            var albumListRequest = FBRequest(graphPath: "322196472693/albums", parameters: nil, HTTPMethod: nil)
            
            albumListRequest.startWithCompletionHandler { albumListConnection, albumListResult, albumListError in
                if let albumListError = albumListError {
                    println("Could not load Facebook albums: \(albumListError)")
                    finishedLoadingClosure()
                    //__galleryCollectionView!.reloadData()
                } else {
                    // Loop through all albums
                    var count = 0
                    for albumDic in albumListResult.objectForKey("data") as! [[String : AnyObject]] {
                        ++count
                        var album = [Picture]()
                        
                        var albumID = albumDic["id"]! as! String
                                                
                        // Get each individual album
                        var albumRequest = FBRequest(graphPath: "\(albumID)/photos", parameters: nil, HTTPMethod: nil)
                        albumRequest.startWithCompletionHandler { albumConnection, albumResult, albumError in
                            
                            if let fbAlbum = albumResult as? [String : AnyObject] {
                                // Get each picture in album
                                for pictureDic in fbAlbum["data"] as! [AnyObject] {
                                    album.append(self.addPicture(pictureDic.objectForKey("id") as! String,
                                        date: NSDate.fromFBDate(pictureDic.objectForKey("created_time") as! String),
                                        thumb: pictureDic.objectForKey("picture") as! String,
                                        src: pictureDic.objectForKey("source") as! String))
                                }
                                
                            }

                            
                            // Once all the pictures have been loaded
                            album.sort({$0.date.timeIntervalSinceNow > $1.date.timeIntervalSinceNow})
                            
                            if album.count > 0 {
                                self.list.append(album)
                            }
                            
                            // Refresh tableView
                            if count == (albumListResult.objectForKey("data") as! [[String : AnyObject]]).count {
                                //self.list = self.list.reverse() // put albums in reverse chronological
                                self.list.sort({$0[0].date.timeIntervalSinceNow > $1[0].date.timeIntervalSinceNow})


                                __galleryCollectionView!.reloadData()
                                finishedLoadingClosure()
                            }
                            
                        }

                    }
                    
                    
                }
            }
        }

    }
    
    func addPicture(id: String, date: NSDate, thumb: String, src: String) -> Picture {
        let newPicture = Picture()
        
        newPicture.id = id
        newPicture.date = date
        newPicture.thumb = thumb
        newPicture.src = src
        
        //dispatch_async(dispatch_get_main_queue()) {
        // getting background priority from global queue fails to load some pictures
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            if let data = NSData(contentsOfURL: NSURL(string:newPicture.thumb)!) {
                newPicture.data = data
            }
        //}

        return newPicture
    }
    
}
