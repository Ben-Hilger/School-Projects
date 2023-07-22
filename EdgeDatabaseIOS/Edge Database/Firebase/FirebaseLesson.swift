//
//  FirebaseLesson.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/13/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import Firebase
import SharedCode

class FirebaseLesson {
    
    private init() {}
    
    func saveLesson(lessonToSave les : Lesson, lesson_number lN : Int, forTeam teamCode : String, completion : @escaping (Bool) -> Void) {
        // Stores the Firebase keys from to shared library
        let keys = FirebaseKeys()
        // Stores the lesson information to save
        var lessonInfo : [String : Any] = [:]
        // Adds the lesson name to the information
        lessonInfo.updateValue(les.lessonName, forKey: keys.lessonName)
        // Stores the drill numbers of the drills
        var array : [Int] = []
        // Explores the drill's in the lesson
        for drill in les.drills as! [Drill] {
            // Adds the drill number to the list
            array.append(Int(truncating: drill.drill_number ?? -1))
        }
        // Adds the list of drill numbers to the information
        lessonInfo.updateValue(array, forKey: keys.lessonDrills)
        // Updates Firebase with the new information
        FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
            if let information = information {
                var lesssons = information["Lesson"] as? [String : Any] ?? [:]
                lesssons.updateValue(lessonInfo, forKey: "Lesson_\(lN)")
                FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: ["Lesson" : lesssons]) { (success) in
                    completion(success)
                }
            } else {
                FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: ["Lesson" : ["Lesson_\(lN)" : lessonInfo]]) { (success) in
                    completion(success)
                }
            }
        }
    }
    
    func loadLessons(forTeam teamCode : String, completion : @escaping ([Lesson]?) -> Void) {
        // Stores the Firebase keys from the shared library
        let keys = FirebaseKeys()
        // Reads the lessons from Firebase
        FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: (teamCode)) { (information) in
            // Checks the information exists
            if let information = information?["Lesson"] as? [String : Any]? ?? [:] {
                // Stores the completed lessons
                var lessons : [Lesson] = []
                // Explores the lessons from the information
                for lesson in information {
                    // Gets the lesson information
                    let lessonInfo = lesson.value as? [String : Any] ?? [:]
                    // Gets the name of the lesson
                    let name = lessonInfo[keys.lessonName] as? String ?? "Unknown"
                    // Gets the drills of the lesson
                    let lessonDrills = lessonInfo[keys.lessonDrills] as? [Int] ?? []
                    // Creates the Lesson instance
                    let finishedLesson = Lesson(n: name)
                    finishedLesson.lessonNumber = KotlinInt(integerLiteral: information.keys.sorted().firstIndex(of: lesson.key) ?? -1)
                    // Explores the dill number
                    for drill_number in lessonDrills {
                        // Gets the drills
                        let drills = DrillManager.getDrillManager().getDrills()
                        // Adds the drill to the lesson
                        finishedLesson.drills.add(drills[drill_number])
                        
                    }
                    // Adds the lesson to the list
                    lessons.append(finishedLesson)
                }
                // Returns the list through the callback
                completion(lessons)
            } else {
                // Returns nil since there was an issue downloading the information
                completion(nil)
            }
        }
    }
    
    static let instance = FirebaseLesson()
}
