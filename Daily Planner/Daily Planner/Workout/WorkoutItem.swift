//
//  WorkoutItem.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

class WorkoutItem {
    
    var name : String
    var numOfReps : Int
    var numberPerReps : [Int]
    
    init(n : String, nR : Int, npR : [Int]) {
        name = n
        numOfReps = nR
        numberPerReps = npR
    }

}
