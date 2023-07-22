//
//  DrillManager.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/4/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class DrillManager {

    //MARK: Drill Management
    
    var drills : [Drill] = []

    func addDrill(withName name: String) -> Drill {
        
        for drill in drills {
            if drill.name.elementsEqual(name) {
                return drill
            }
        }
        
        let newDrill = Drill(name: name, category: [], position: DrillPosition(n: "Unassigned"), sport: Sport(n: "Unassigned"))
        newDrill.drill_number = KotlinInt(integerLiteral: drills.count)
        return newDrill
        
    }
    
    func getDrills() -> [Drill] {
        return drills
    }
    
    func setDrills(drills d : [Drill]) {
        drills = d
    }
    
    // MARK: Drill Category Management
    var drillCategories : [DrillCategory] = []
    
    func getDrillCategory(withName n : String) -> DrillCategory {
        
        for category in drillCategories {
            if category.categoryName == n {
                return category
            }
        }
        
        let drillCategory = DrillCategory(name: n)
        drillCategories.append(drillCategory)
        return drillCategory
        
    }
    
    func getDrillCategories() -> [DrillCategory] {
        return drillCategories
    }
    
    // MARK: Drill Loading
    func loadDrills(completion : @escaping (Bool) -> Void) {
        if let team = TeamManager.instance.teamEditing {
            FirebaseDrills.instance.loadDrills(forTeam: team.teamCode) { (drills) in
                if let drills = drills {
                    self.drills = drills
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func saveDrill(drillToSave drill : Drill, withDrillNumber dn : Int?=nil,completion : @escaping (Bool) -> Void) {
        if let team = TeamManager.instance.teamEditing {
            FirebaseDrills.instance.saveDrill(drillToSave: drill, drill_number: dn ?? drills.count, forTeam: team.teamCode) { (success) in
                completion(success)
            }
        }
    }
    
    func addAndSaveDrill(drillToSave drill : Drill, completion : @escaping (Bool) -> Void) {
        drill.drill_number = KotlinInt(integerLiteral: self.drills.count)
        saveDrill(drillToSave: drill, withDrillNumber: (drill.drill_number as! Int)) { (success) in
            completion(success)
        }
    }
    
    // MARK: Static Constants
    
    private static let manager : DrillManager = DrillManager()
    
    static func getDrillManager() -> DrillManager {
        return manager
    }
    
    
}
