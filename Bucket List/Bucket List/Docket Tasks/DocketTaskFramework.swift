//
//  BucketListItem.swift
//  Bucket List
//
//  Created by Ben Hilger on 11/14/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation


class DocketTaskFramework {
    
    var name : String!
    var description : String!
    var dateAdded : Date
    
    var taskType : DOCKET_TYPE!
    
    var potentialDates : [Date] = []
    var location : String?
    
    init(n : String, des : String, type : DOCKET_TYPE){
        name = n
        description = des
        dateAdded = Date()
        
        taskType = type
    }
    
    func getName() -> String {
        return name
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getDateAdded() -> Date {
        return dateAdded
    }
    
    func getReadableDateAdded() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: dateAdded)
    }
    
    func hasLocation() -> Bool {
        return location != nil
    }
    
    func setLocation(loc : String){
        location = loc
    }
    
    func getLocation() -> String {
        return hasLocation() ? location! : ""
    }
    
    func addPotentialDate(d : Date) {
        potentialDates.append(d)
    }
    
    func hasPotentialDates() -> Bool {
        return potentialDates.count > 0
    }
    
    func getPotentialDates() -> [Date] {
        return potentialDates
    }
    
    func getReadablePotentialDates() -> [String] {
        var dates : [String] = []
        
        for index in 0..<potentialDates.count {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dates.append(formatter.string(from: potentialDates[index]))
        }
        
        return dates
    }
    
    
    enum DOCKET_TYPE {
        case REMINDER, EVENT
    }
}

