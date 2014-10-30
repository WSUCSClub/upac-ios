//
//  NSDateExtension.swift
//  UPAC
//
//  Created by Marquez, Richard A on 10/22/14.
//  Copyright (c) 2014 wsu-cs-club. All rights reserved.
//

import Foundation

extension NSDate {
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
    
    func dayNumStr() -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.stringFromDate(self)
    }

}
