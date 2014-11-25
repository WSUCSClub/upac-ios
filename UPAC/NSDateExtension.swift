//
//  NSDateExtension.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/22/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

extension NSDate {
    func medStr() -> String {
        return NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    func dayStr() -> String {
        return NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
    }
    
    func timeStr() -> String {
        return NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    func weekdayStr() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.stringFromDate(self)
    }
    
    func monthStr() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.stringFromDate(self)
    }
    
    func dayNumStr() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(self)
    }
    
    class func fromFBDate(fbDate: String) -> NSDate {
        var date = NSDate()
        
        var dateFormatter = NSDateFormatter()
        
        let dateTimeFormat = "yyyy'-'MM'-'dd'T'HH:mm:ssZ"
        let dateFormat = "yyyy'-'MM'-'dd"
        
        dateFormatter.dateFormat = dateTimeFormat
        
        if dateFormatter.dateFromString(fbDate) != nil {
            date = dateFormatter.dateFromString(fbDate)!
        } else {
            dateFormatter.dateFormat = dateFormat
            date = dateFormatter.dateFromString(fbDate)!
        }
        
        return date
    }

}
