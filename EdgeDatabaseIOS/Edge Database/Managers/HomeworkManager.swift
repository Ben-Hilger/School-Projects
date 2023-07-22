//
//  HomeworkManager.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/26/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class HomeworkManager {
    
    private var homework : [Homework] = []
    
    private init() {}
    
    func addHomework(withName name : String) -> Homework {
        let tempHome : Homework = Homework(name: name)
        tempHome.homework_id = KotlinInt(integerLiteral: homework.count)
        for home in homework {
            if home.name == name {
                return home
            }
        }
        homework.append(tempHome)
        return tempHome
    }

    func getHomework() -> [Homework] {
        return homework
    }
    
    func saveHomework(homeworkToSave hw : Homework, completion : @escaping (Bool) -> Void) {
        if hw.homework_id != nil {
            if let team = TeamManager.instance.teamEditing {
                FirebaseHomework.instance.saveHomework(homeworkToSave: hw, forTeam: team.teamCode) { (success) in
                    completion(success)
                }
            } else {
                completion(false)
            }
        } else {
            print("Homework couldn't save properly")
            completion(false)
        }
    }
       
    func loadHomework(completion : @escaping ([Homework]) -> ()) {
        if let team = TeamManager.instance.teamEditing {
            FirebaseHomework.instance.loadHomework(forTeam: team.teamCode) { (homework) in
                if let homework = homework {
                    self.homework = homework
                    completion(homework)
                } else {
                    completion([])
                }
            }
        }
    }
    
    func assignHomeworkToPlayer(playerUsername pUsername : String, coachUsername cUsername : String, forHomework hw : Homework, completion : @escaping (Bool) -> ()) {
        hw.playerAssigned = pUsername
        hw.instructorAssigned = cUsername
        if let team = TeamManager.instance.teamEditing  {
            FirebaseHomework.instance.saveAssignedHomework(forTeam: team.teamCode, homeworkToSave: hw) { (success) in
                hw.playerAssigned = nil
                hw.instructorAssigned = nil
                completion(success)
            }
        }
    }
    
    func loadAssignedHomeworks(playerUsername pUsername : String, completion : @escaping ([Homework]) -> ()) {
        if let team = TeamManager.instance.teamEditing {
            FirebaseHomework.init().loadHomework(forTeam: team.teamCode) { (allHomework) in
                var homework : [Homework] = []
                FirebaseHomework.init().loadAssignedHomework(forTeam: team.teamCode, forUsername: pUsername) { (homeworkIds) in
                    for id in homeworkIds {
                        for home in allHomework ?? [] {
                            if Int(truncating: home.homework_id!) == Int(id.key) {
                                let startTime = (id.value as? [String] ?? [])[0]
                                let endTime = (id.value as? [String] ?? [])[1]
                                let homeCopy = home.doCopy()
                                homeCopy.startTime = startTime
                                homeCopy.dueTime = endTime
                                homework.append(homeCopy)
                            }
                        }
                    }
                    completion(homework)
                }
            }

        }
    }
    
    func loadMassAssignedHomework(completion : @escaping ([String : [Homework]]) -> ()) {
        var finished : [String : [Homework]] = [:]
        if let team = TeamManager.instance.teamEditing {
            print("Line 109")
            FirebaseHomework.instance.loadAllAssignedHomework(forTeam: team.teamCode) { (values) in
                print("Line 111")
                FirebaseHomework.instance.loadHomework(forTeam: team.teamCode) { (allHomework) in
                    if let allHomework = allHomework {
                        for value in values {
                            var allhomework : [Homework] = []
                            for assigned in value.value {
                                for homework in allHomework {
                                    if Int(truncating: homework.homework_id!) == Int(assigned.key) {
                                        let home = homework.doCopy()
                                        home.startTime = (assigned.value as? [String] ?? [])[0] 
                                        home.dueTime = (assigned.value as? [String] ?? [])[1] 
                                        allhomework.append(home)
                                    }
                                }
                            }
                            finished.updateValue(allhomework, forKey: value.key)
                        }
                        completion(finished)
                    } else {
                        completion([:])
                    }
                }
            }
        } else {
            completion([:])
        }
    }
    
    func markAsCompleted(forHomework hw : Homework, completion : @escaping (Bool) -> ()) {
        if let team = TeamManager.instance.teamEditing {
            FirebaseHomework.instance.markHomeworkasCompleted(forTeam: team.teamCode, forUsername: UserManager.getUserManager().getUser().uid, withHomework: hw) { (success) in
                completion(success)
            }
        }
    }
    
    private static let homeworkMan : HomeworkManager = HomeworkManager()
    
    static func getHomeworkManager() -> HomeworkManager {
        return homeworkMan
    }
}
