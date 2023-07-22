//
//  Logger.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/12/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation

struct Logger {

    var tag : String = "Placeholder"
    
    init(tag : String) {
        self.tag = tag
    }
    
    func writeInfo(msg : String) {
        print("[\(tag)] \(msg)")
    }
 
    func writeError(msg : String) {
        print("[\(tag)][ERROR] \(msg)")
    }
    
}
