//
//  InventotyDate.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation

class InventoryDate {
    
    var date : Date
    
    var item : [Item]!
    
    init(i : [Item]){
        date = Date()
        item = i
    }
    
    init(d : Date, i : [Item]){
        date = d
        item = i
    }
    
    init(d : String){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        date = formatter.date(from: d)!
    }
    
    func getDateasString() -> String {
        let form = DateFormatter()
        form.dateFormat = "MM-dd-yyyy"
        return form.string(from: date)
    }
    
    
}
