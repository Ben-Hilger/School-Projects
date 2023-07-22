//
//  Wokout.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/27/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

class WorkOut {
    
    var day : String
    
    var workOutElements : [String : [WorkoutItem]] = [:]
    
    init(d : String) {
        day = d
        setupDays()
    }
    
    func setupDays() {
        
        workOutElements = [
            "Monday" : [
                WorkoutItem(n: "Quads: One Leg DB Squat", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "Hamstring: Deadlift", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "CST: Overhead DB Press", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "BBF: Pull Ups", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "Core: Planks", nR: 3, npR: [10, 10, 10])
            ],
            "Tuesday" : [
                WorkoutItem(n: "Quads: DB Lunge", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "Hamstring: Hip Raises", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "CST: DB Bench Press", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "BBF: Pull Ups", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "Core: Planks", nR: 3, npR: [10, 10, 10])
            ],
            "Wednesday" : [
                WorkoutItem(n: "Quads: DB One Leg Squat", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "Hamstring: Straight Leg DL", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "CST: DB Incline Press", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "BBF: Pull Ups", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "Core: Planks", nR: 3, npR: [10, 10, 10])
            ],
            "Thursday" : [],
            "Friday" : [
                WorkoutItem(n: "Quads: One Leg DB Squat", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "Hamstring: Deadlift", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "CST: Overhead DB Press", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "BBF: Pull Ups", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "Core: Planks", nR: 3, npR: [10, 10, 10])
            ],
            "Saturday": [
                WorkoutItem(n: "Quads: DB Lunge", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "Hamstring: Hip Raises", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "CST: DB Bench Press", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "BBF: Pull Ups", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "Core: Planks", nR: 3, npR: [10, 10, 10])
            ],
           "Sunday": [
                WorkoutItem(n: "Quads: DB One Leg Squat", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "Hamstring: Straight Leg DL", nR: 3, npR: [10,10,10]),
                WorkoutItem(n: "CST: DB Incline Press", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "BBF: Pull Ups", nR: 3, npR: [10, 10, 10]),
                WorkoutItem(n: "Core: Planks", nR: 3, npR: [10, 10, 10])
            ]
        ]
        
    }
    
}
