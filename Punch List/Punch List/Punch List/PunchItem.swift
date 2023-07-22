//
//  PunchList.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

class PunchItem : Equatable {
    
    
    var item : String
    var category : Category
    
    var dueDate : Date
    var completionDate : Date?
    
    var fireStoreDIR : String?
    
    init(i : String, cat : Category, dD : Date) {
        item = i
        category = cat
        dueDate = dD
    }

    func getItem() -> String {
        return item
    }
    
    func getDueDate() -> Date {
        return dueDate
    }
    
    func getCategory() -> Category {
        return category
    }
    
    func setCompletionDate(d : Date) {
        completionDate = d
    }
    
    func getCompletionDate() -> Date? {
        return completionDate
    }
    
    static func == (lhs: PunchItem, rhs: PunchItem) -> Bool {
        return lhs.getItem()==rhs.getItem() && lhs.getCategory().getName()==rhs.getCategory().getName() && lhs.getDueDate()==rhs.getDueDate()
    }
    
}
