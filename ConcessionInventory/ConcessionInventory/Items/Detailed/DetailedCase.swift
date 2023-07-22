//
//  DetailedCase.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation

class DetailedCase : CaseCounter {
    
    var dateInventoried : String!
    
    init(n: String, amt: Int, dI : String) {
        super.init(n: n, amt: amt)
        dateInventoried = dI
    }
}
