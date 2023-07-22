//
//  ArrayUtil.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class ArrayUtil {
    
    static func categoriesToStrings(categories cat : [DrillCategory]) -> [String] {
        
        var str : [String] = []
        
        for c in cat {
            str.append(c.categoryName)
        }
        
        return str
    
    }
    
}
