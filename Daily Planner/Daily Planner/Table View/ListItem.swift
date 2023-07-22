//
//  ListItem.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/27/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

class ListItem {
    
    var descrip : String!
    
    var clickFunction : () -> Void
    
    init(d : String, onClick : @escaping () -> Void) {
        descrip = d
        clickFunction = onClick
    }
    
    func clicked() {
        clickFunction()
    }
    
    
}
