//
//  FirebaseHomework.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/14/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import Firebase
import SharedCode

class FirebaseHomework {
    
    init() {}
    
    func saveHomework(homeworkToSave hw : Homework, forTeam teamCode : String, completion : @escaping (Bool) -> Void) {
        // Stores the Firebase keys from the shared library
        let keys = FirebaseKeys()
        // Stores the information to save to Firebase
        var info : [String : Any] = [:]
        // Adds the homework name to the
        info.updateValue(hw.name, forKey: keys.homeworkName)
        // Stores the drill numbers
        var drillNumbers : [Int] = []
        // Explores the drills in the homework
        for drill in hw.drills as! [Drill] {
            // Checks to see if the specified drill has a drill number
            if let drill_number = drill.drill_number {
                // Adds the drill number to the list
                drillNumbers.append(Int(truncating: drill_number))
            }
        }
        // Adds the completed drill numbers to the information
        info.updateValue(drillNumbers, forKey: keys.homeworkDrills)
        // Adds a lesson plan name to the information to save
        if let lessonPlanName = hw.lesson?.lessonName {
            info.updateValue(lessonPlanName, forKey: keys.homeworkLessonPlan)
        }
        // Adds the start and due time to the homework
        info.updateValue(DateUtil.stringToDate(string: hw.startTime) ?? Date(), forKey: keys.homeworkStartTime)
        info.updateValue(DateUtil.stringToDate(string: hw.dueTime) ?? Date(), forKey: keys.homeworkDueTime)
        // Stores the comments
        var com : [String : Any] = [:]
        // Explores the comments contained in the homework
        for index in 0..<hw.comments.count {
            // Gets the current comment
            let comment = hw.comments[index] as! Comments
            // Adds the comments content
            com.updateValue([
                comment.name,
                comment.content
            ], forKey: "Comment_\(index)")
            
        }
        // Adds the comments to the information array
        info.updateValue(com, forKey: keys.homeworkCommentsID)
        // Stores the videos associated with the homework
        var videos : [String : String] = [:]
        // Explores the videos in the homework
        for video in hw.videos {
            // Adds the video string to the array
            videos.updateValue(video.value as! String, forKey: video.key as! String)
        }
        // Adds all of the videos to the information array
        info.updateValue(videos, forKey: "Homework_Videos")
        if let playerAssigned = hw.playerAssigned, let coachAssigned = hw.instructorAssigned {
            info.updateValue(playerAssigned, forKey: keys.homeworkPlayerID)
            info.updateValue(coachAssigned, forKey: keys.homeworkCoachID)
        }
        // Gets the infromation from firebase about current homewokr
        FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
            // Checks if there's any info to read
            if let information = information {
                // Gets the current homeework
                var currentHomework = information["Homework"] as? [String : Any] ?? [:]
                // Updates the homework value for the saving homework
                currentHomework.updateValue(info, forKey: "Homework_\(hw.homework_id!)")
                // Updates the information on Firebase
                FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: ["Homework"  : currentHomework]) { (success) in
                    completion(success)
                }
            } else {
                // Updates the information on Firebase
                FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: ["Homework"  : ["Homework_\(hw.homework_id!)" : info]]) { (success) in
                    completion(success)
                }
            }
        }
    }
     
    func loadHomework(forTeam teamCode : String, completion : @escaping ([Homework]?) -> Void) {
        // Stores the Firebase keys from the shared library
        let keys = FirebaseKeys()
        // Reads the homework saved at the specified location
        Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).getDocument { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
            } else {
                if let data = snapshot?.data() {
                    var finishedHomeworks : [Homework] = []
                    for homework in data["Homework"] as? [String : Any] ?? [:] {
                        let homeworkData = homework.value as? [String : Any] ?? [:]
                        
                        let name = homeworkData[keys.homeworkName] as? String ?? "Unknown"
                        let drills = homeworkData[keys.homeworkDrills] as? [Int] ?? []
                        let dueDate = homeworkData[keys.homeworkDueTime] as! Timestamp
                        let startDate = homeworkData[keys.homeworkStartTime] as! Timestamp
                        let lessonPlan = homeworkData[keys.homeworkLessonPlan] as? String ?? ""
                        
                        let finishedHomework = Homework(name: name)
                        finishedHomework.dueTime = DateUtil.dateToString(date: dueDate.dateValue())
                        finishedHomework.startTime = DateUtil.dateToString(date: startDate.dateValue())
                        finishedHomework.name = name
                        finishedHomework.homework_id = KotlinInt(integerLiteral: Int(homework.key.suffix(1))!)
                        
                        let comments = homeworkData[keys.homeworkCommentsID] as? [String : Any] ?? [:]
                        
                        // Explores the comments downloaded from Firebase
                        for index in 0..<comments.count {
                            if let values = comments[comments.keys.sorted()[index]] as? [String] {
                                let name = values[0]
                                let content = values[1]
                               
                                let com = Comments(name: name, content: content)
                                finishedHomework.comments.add(com)
                           }
                        }
                        // Gets the videos downloaded from Firebase
                        let videos : [String : String] = homeworkData["Homework_Videos"] as? [String : String] ?? [:]
                        // Explores the videos
                        for video in videos {
                            // Adds the video information to the finished homework
                            finishedHomework.videos[video.key] = video.value
                        }
                        // Gets the drill manager which store the loaded drills for this team
                        let drillManager = DrillManager.getDrillManager()
                        // Explores the drill numbers downloaded from Firebase
                        for drill in drills {
                            // Adds the specified drill to the homework
                            finishedHomework.drills.add(drillManager.drills[drill])
                        }
                        // Adds the homework to the list
                        finishedHomeworks.append(finishedHomework)
                    }
                    completion(finishedHomeworks)
                } else {
                    completion([])
                }
            }
        }
    }
    
    func saveAssignedHomework(forTeam teamCode : String, homeworkToSave hw : Homework, completion : @escaping (Bool) -> ()) {
        let keys = FirebaseKeys()
        if let player = hw.playerAssigned, let _ = hw.instructorAssigned {
            print("HTEEREREGAERGAwe")
            Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(player).document(keys.homeworkID).getDocument { (snapshot, error) in
                print("HERERE")
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                } else {
                    if let data = snapshot?.data() {
                        var currentAssignedHomework = data[keys.assignedHomeworkID] as? [String : [String]] ?? [:]
                        currentAssignedHomework.updateValue([hw.startTime, hw.dueTime], forKey: String(Int(truncating: hw.homework_id!)))
                        print(currentAssignedHomework)
                        Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(keys.homeworkID).document(player).setData([keys.assignedHomeworkID : currentAssignedHomework], merge: true) { (error) in
                            print("ergsbaebstbvsrsrrvar")
                            if let error = error {
                                print(error.localizedDescription)
                                completion(false)
                            } else {
                                completion(true)
                            }
                        }
                    } else {
                        Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(keys.homeworkID).document(player).setData([keys.assignedHomeworkID : [String(Int(truncating: hw.homework_id!)) : [hw.startTime, hw.dueTime]]]) { (error) in
                            if let error = error {
                                print(error.localizedDescription)
                                completion(false)
                            } else {
                                completion(true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loadAssignedHomework(forTeam teamCode : String, forUsername username : String, completion : @escaping ([String : Any]) -> ()) {
        let keys = FirebaseKeys()
        print(username)
        Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(keys.homeworkID).document(username).getDocument { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            completion(snapshot?.data()?[keys.assignedHomeworkID] as? [String : Any] ?? [:])
        }
    }
    
    func loadAllAssignedHomework(forTeam teamCode : String, completion : @escaping ([String : [String : Any]]) -> ()) {
        var completed  : [String : [String : Any]] = [:]
        let keys = FirebaseKeys()
        Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(keys.homeworkID).getDocuments { (docSnap, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([:])
            } else {
                if let documents = docSnap?.documents {
                    for document in documents {
                        print(document.data()[keys.assignedHomeworkID]!)
                        completed.updateValue(document.data()[keys.assignedHomeworkID]! as! [String : Any], forKey: document.documentID)
                    }
                    completion(completed)
                } else {
                    completion([:])
                }
            }
        }
    }
    
    func markHomeworkasCompleted(forTeam teamCode : String, forUsername username : String, withHomework hw : Homework, completion : @escaping (Bool) -> ()) {
        let keys = FirebaseKeys()
        Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(keys.homeworkID).document(username).getDocument { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                if let data = snapshot?.data() {
                    var currentHomework = data[keys.assignedHomeworkID] as? [Int] ?? []
                    var completedHomework = data[keys.completedHomeworkID] as? [Int] ?? []
                    if let index = currentHomework.firstIndex(of: Int(truncating: hw.homework_id!)) {
                        currentHomework.remove(at: index)
                    }
                    if !completedHomework.contains(Int(truncating: hw.homework_id!)) {
                        completedHomework.append(Int(truncating: hw.homework_id!))
                    }
                    Firestore.firestore().collection(keys.teamInformationKey).document(teamCode).collection(username).document(keys.homeworkID).setData([keys.assignedHomeworkID : currentHomework, keys.completedHomeworkID : completedHomework]) { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                            completion(false)
                        } else {
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
    
    static let instance = FirebaseHomework()
    
}
