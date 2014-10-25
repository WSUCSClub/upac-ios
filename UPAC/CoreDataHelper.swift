//
//  CoreDataHelper.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/24/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let coreDataHelper = CoreDataHelper()

class CoreDataHelper {
    var managedObjectContext: NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        } else {
            return nil
        }
        }()

    func saveData() {
        var error: NSError? = nil
        if !self.managedObjectContext!.save(&error) {
            NSLog("error: \(error)")
            abort()
        }
    }

}
