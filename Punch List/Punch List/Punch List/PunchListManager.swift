//
//  PunchListManager.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/29/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

class PunchListManager {
    
    var punchItems : [PunchItem] = []
    
    private init() {

    }
    
    func getPunchList() -> [PunchItem] {
        return punchItems
    }
    
    func addPunchItem(item : PunchItem) {
        punchItems.append(item)
    }
    
    func removePunchItem(item : PunchItem) {
        punchItems.remove(at: punchItems.firstIndex(of: item)!)
    }
    
    func setPunchList(items : [PunchItem]) {
        punchItems = items
    }
    
    func getCategories() -> [String] {
        var cats : [String] = ["Select Category"]
        
        for item in punchItems {
            if !cats.contains(item.getCategory().getName()) {
                cats.append(item.getCategory().getName())
            }
        }
        
        cats.append("Other")
        
        return cats
    }
    
    static var punchMan : PunchListManager = PunchListManager()
    
    static func getPunchListManager() -> PunchListManager {
        return punchMan
    }
    
    
}
