//
//  FBHelper.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/14/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

let fbGroupID: String = "322196472693"

class FBHelper{
    
    var fbSession:FBSession?;
    
    init(){
        self.fbSession = nil;
    }
    
    func fbAlbumRequestHandler(connection:FBRequestConnection!, result:AnyObject!, error:NSError!){
        
        if let gotError = error{
            println(gotError.description);
        }
        else{
            let graphData = result.valueForKey("data") as [FBGraphObject]; // !!!! added :String
            for obj:FBGraphObject in graphData{
                let desc = obj.description;
                println(desc);
                let name = obj.valueForKey("name") as String;
                println(name);
                if(name == "ETC"){
                    let test="";
                }
                let id = obj.valueForKey("id") as String;
                var cover = "";
                if let existsCoverPhoto : AnyObject = obj.valueForKey("cover_photo"){
                    let coverLink = existsCoverPhoto  as String;
                    cover = "/\(coverLink)/photos";
                }
                
                //println(coverLink);
                let link = "/\(id)/photos";
                
                
            }
        }
    }
        
    func fetchAlbum(){
        
        let request =  FBRequest.requestForMe();
        request.graphPath = "me/albums";
        
        request.startWithCompletionHandler(fbAlbumRequestHandler);
    }
    
    func logout(){
        fbSession?.closeAndClearTokenInformation();
        fbSession?.close();
    }
    
    func login(){
        FBSession.openActiveSessionWithAllowLoginUI(true);
    }
    
    func fbHandler(session:FBSession!, state:FBSessionState, error:NSError!){
        if let gotError = error{
            //got error
        }
        else{
            
            fbSession = session;
            
            FBRequest.requestForMe()?.startWithCompletionHandler(self.fbRequestCompletionHandler);
        }
    }
    
    func fbRequestCompletionHandler(connection:FBRequestConnection!, result:AnyObject!, error:NSError!){
        if let gotError = error{
            //got error
        }
        else{
            //
        }
    }
}