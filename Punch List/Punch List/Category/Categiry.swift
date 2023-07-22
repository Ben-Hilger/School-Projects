//
//  Categiry.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/29/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

class Category : Equatable {
    
    var name : String
    
    init(n : String) {
        name = n
    }
    
    func getName() -> String {
        return name
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.getName()==rhs.getName()
    }
    

}
