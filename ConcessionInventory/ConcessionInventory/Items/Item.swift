//
//  Item.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/19/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation

class Item {
    
     var name : String!
    
     var count = 0
     var amtPerCase = 0
    
     var cases : [CaseCounter] = []
     var looseItems : Int = 0
    
    init(name : String){
        self.name = name
    }
    
    init(name : String, amtPerCase : Int, c : Int){
        self.name = name
        self.amtPerCase = amtPerCase
        count = c
    }
    
    func getName() -> String {
        return name
    }
    
    func getAmountPerCase() -> Int {
        return amtPerCase
    }
    
    func getCases() -> [CaseCounter] {
        return cases
    }
    
    func addCase(c : CaseCounter){
        cases.append(c)
    }
    
    func getCount() -> Int {
        updateCount()
        return count
    }
    
    func getLooseItems() -> Int {
        return looseItems
    }
    
    func updateLooseItems(li: Int){
        looseItems = li
    }
    
    func updateCount() {
        var sum = 0
        for index in 0..<cases.count {
            sum += cases[index].getAmount()
        }
        count = sum + looseItems
    }
}
