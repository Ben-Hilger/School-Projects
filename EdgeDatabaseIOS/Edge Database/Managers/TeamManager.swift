//
//  TeamManager.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/6/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class TeamManager {
    
    var teams : [Team] = []
    
    var teamEditing : Team?
    
    private init() {
        
    }

    func getTeamFromTeamCode(tc : String) -> Team {
        for team in teams {
            if team.teamCode == tc {
                return team
            }
        }
        
        return Team(tC: tc, n: "")
    }
    
    static let instance = TeamManager()
    
}
