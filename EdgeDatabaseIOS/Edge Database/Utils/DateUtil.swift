//
//  DateUtil.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/16/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation

class DateUtil {
    
    static func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyy"
        
        return formatter.string(from: date)
    }
    
    static func stringToDate(string : String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyy"
        return formatter.date(from: string)
    }
}
