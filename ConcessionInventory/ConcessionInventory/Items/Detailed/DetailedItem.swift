//
//  DetailedItem.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation

class DetailedItem : Item, Equatable {
 
    var dcases : [DetailedCase] = []
    override init(name: String) {
        super.init(name: name)
        
    }
    
    func mergeWithItem(item : Item, d : String) {
        for index in 0..<item.getCases().count {
            let curCase = item.getCases()[index]
            let detailedCase = DetailedCase(n: curCase.getName(), amt: curCase.getAmountPerCase(), dI: d)
            detailedCase.setAmount(a: curCase.getAmount())
            dcases.append(detailedCase)
        }
        updateCount()
    }
    
    static func == (lhs: DetailedItem, rhs: DetailedItem) -> Bool {
        return lhs.getName() == rhs.getName()
    }
    
    override func updateCount() {
        var sum = 0
        for index in 0..<dcases.count {
            sum += dcases[index].getAmount()
        }
        count = sum + getLooseItems()
    }
    
}
