//
//  CaseCounter.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/19/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation

class CaseCounter {
    
    private var name : String!
    private var amtPerCase : Int!
    private var amt : Int = 0
    
    init(n : String, amt : Int){
        name = n
        amtPerCase = amt
    }
    
    func getName() -> String {
        return name
    }
    
    func getAmountPerCase() -> Int {
        return amtPerCase
    }
    
    func getAmount() -> Int {
        return amtPerCase*amt
    }
    
    func setAmount(a : Int) {
        amt = a
    }
    
    func getAmountOfCases() -> Int {
        return amt
    }
    
}
