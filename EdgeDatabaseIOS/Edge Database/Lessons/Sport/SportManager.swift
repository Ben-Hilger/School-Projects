//
//  SportManager.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/14/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class SportManager {
    
    
    let unassigned : Sport = Sport(n: "Unassigned")
    let softball : Sport = Sport(n: "Softball")

    var currentSports : [Sport] = []
    
    private init() {
        currentSports = [
            softball
        ]
    }

    func getSport(withName name : String) -> Sport {
        let tempSport = Sport(n: name)
        
        for sport in currentSports {
            if sport.name == name {
                return sport
            }
        }
        
        currentSports.append(tempSport)
        return tempSport
        
    }

    func getPosition(withName name: String, withSportName sportName: String) -> DrillPosition {
        let sport = getSport(withName: sportName)
        
        for position in sport.positions {
            if let position = position as? DrillPosition {
                if position.name == name {
                    return position
                }
            }
        }
        let position = DrillPosition(n: name)
        sport.positions.add(position)
        return position
    }
    
    static let sportManager : SportManager = SportManager()
    
    
}
