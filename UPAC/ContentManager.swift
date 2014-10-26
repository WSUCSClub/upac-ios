//
//  ContentManager.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/24/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import CoreData

class ContentManager {
    var list = [NSManagedObject]()
    let contentType: String
    
    init(contentType: String) {
        self.contentType = contentType

        populateList()
        coreDataHelper.saveData()
        
        list = fetchStored()
    }
    
    func clearLocalStorage() {
        let request = NSFetchRequest(entityName: contentType)
        list = coreDataHelper.managedObjectContext!.executeFetchRequest(request, error: nil) as [NSManagedObject]
        
        for item in list {
            coreDataHelper.managedObjectContext!.deleteObject(item)
        }
        
        list = []
    }
    
    func populateList() {
        assert(false, "This method must be overridden")
    }
    
    func fetchStored() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: contentType)
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [ sortDescriptor ]
        
        return coreDataHelper.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as [NSManagedObject]!
    }

}

