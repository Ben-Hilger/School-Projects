//
//  FirebaseDrills.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/13/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import Firebase
import SharedCode

class FirebaseDrills {
    
    /**
     Makes the no-argument constructor private
     */
    private init() {}
    
    func saveDrill(drillToSave drill : Drill, drill_number : Int, forTeam teamCode : String, completion : @escaping (Bool) -> Void) {
        // Stores the keys of the drill information
        var drillInfo : [String : Any] = [:]
        // Stores the Firebase keys from the Shared Library
        var keys = FirebaseKeys()
        // Adds the drill's information to the dictionary
        drillInfo.updateValue(drill.name, forKey: keys.drillName)
        drillInfo.updateValue(ArrayUtil.categoriesToStrings(categories: drill.category as! [DrillCategory]), forKey: keys.drillCategory)
        drillInfo.updateValue(drill.difficulty, forKey: keys.drillDifficulty)
        drillInfo.updateValue(drill.sport.name, forKey: keys.drillSport)
        drillInfo.updateValue(drill.position.name, forKey: keys.drillPosition)
        drillInfo.updateValue(drill.reps, forKey: keys.drillReps)
        drillInfo.updateValue(drill.drill_number ?? drill_number, forKey: keys.drillNumber)
        // Checks to ensure there's a video associated with the drill
        if let videoURL = drill.videoURL {
            // Adds the video link to the drill info array
            drillInfo.updateValue(videoURL, forKey: keys.drillVideo)
        }
        // Updates Firebase with the new information
        FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
            if let information = information {
                var drills = information["Drills"] as? [String : Any] ?? [:]
                drills.updateValue(drillInfo, forKey: "Drill_\(drill_number)")
                FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: drills) { (success) in
                    completion(success)
                }
            } else {
                FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: ["Drills" : drillInfo]) { (success) in
                    completion(success)
                }
            }
        }
    }
    
    /**
     */
    func loadDrills(forTeam teamCode : String, completion : @escaping ([Drill]?) -> Void) {
        let keys = FirebaseKeys()
        FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
            if let information = information {
                // Stores the completed drills
                var completedDrills : [Drill] = []
                // Explores the drill information
                let drills : [String : Any] = information["Drills"] as? [String : Any] ?? [:]
                print(drills)
                for info in drills {
                    // Gets the necessary drill information
                    let drillInfo = info.value as! [String : Any]
                    let name = drillInfo[keys.drillName] as? String ?? "Unknown"
                    let category = drillInfo[keys.drillCategory] as? [String] ?? ["Unassigned"]
                    let difficulty = drillInfo[keys.drillDifficulty] as? String ?? "Unknown"
                    let sport = drillInfo[keys.drillSport] as? String ?? "Unknown"
                    let position = drillInfo[keys.drillPosition] as? String ?? "Unknown"
                    let rep = drillInfo[keys.drillReps] as? [Int] ?? []
                    let drill_number = drillInfo[keys.drillNumber] as? Int ?? completedDrills.count
                    let drill_video : String? = drillInfo[keys.drillVideo] as? String
                    // Stores the categories
                    var categories : [DrillCategory] = []
                    // Explores the category strings pulled from the database
                    for cat in category {
                        // Creates/Gets Drill Categories with the same name
                        categories.append(DrillManager.getDrillManager().getDrillCategory(withName: cat))
                    }
                    // Creates a drill instance
                    let drill = Drill(name: name, category: NSMutableArray(array: categories), position: SportManager.sportManager.getPosition(withName: position, withSportName: sport), sport: SportManager.sportManager.getSport(withName: sport))
                    // Adds extra information
                    drill.sport = SportManager.sportManager.getSport(withName: sport)
                    drill.difficulty = difficulty
                    drill.drill_number = KotlinInt(integerLiteral: drill_number)
                    // Adds the video url if it exists
                    drill.videoURL = drill_video
                    drill.reps = NSMutableArray(array: rep)
                    // Adds the completed drill to the array
                    completedDrills.append(drill)
                }
                // Returns the completed drills through the callback
                print("sdfgfdsasdf: \(completedDrills.count)")
                completion(completedDrills)
            } else {
                completion(nil)
            }
        }
    }
    // Stores the instance that other classes can use to access the functions
    static let instance = FirebaseDrills()
    
}
