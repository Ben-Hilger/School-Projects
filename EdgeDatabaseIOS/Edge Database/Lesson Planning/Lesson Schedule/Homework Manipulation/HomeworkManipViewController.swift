//
//  HomeworkManipViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/26/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class HomeworkManipViewController : UITableViewController {
    
    @IBOutlet var ManipTitle : UINavigationItem!
    
    var source : HomeworkManipSource!
    
    var homeworkEditing : Homework?
    
    var delegate : HomeworkManipDelegate?
    
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            
            if UserManager.getUserManager().getUser().accountType == AccountType.coach {
//                for userUID in UserManager.getUserManager().getUser().getCurrentStudents() {
//                    FirestoreManager.getFirestore().loadUser(withUID: userUID) { (user, success) in
//
//                        DispatchQueue.main.async {
//                            if success {
//                                print("Here")
//                                DispatchQueue.main.async {
//                                    self.users.append(user)
//                                    self.tableView.reloadData()
//                                }
//                            }
//                        }
//
//                    }
//                }
            } else {
              //  self.users = [UserManager.getUserManager().getUser()]
            }
        }
        
        switch source {
        case .Drills:
            ManipTitle.title = "Select Drills"
            break
        case .LessonPlan:
            ManipTitle.title = "Select Lesson Plan"
            break
        case .Player:
            ManipTitle.title = "Select Player"
            break
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch source {
        case .Drills:
            return DrillManager.getDrillManager().getDrills().count
        case .LessonPlan:
            return LessonManager.getLessonManager().getLessonPresets().count
        case .Player:
            return users.count
        case .none:
            return 0
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenterDetail") as! LeftDetailTableViewCell
        
        var content : String = ""
        
        switch source {
        case .Drills:
            let drill = DrillManager.getDrillManager().getDrills()[indexPath.row]
            content = drill.name
            for d in homeworkEditing?.drills as! [Drill] {
                if d.name == drill.name {
                    cell.accessoryType = .checkmark
                    break
                }
            }
            cell.accessoryType = .none
        case .LessonPlan:
            let lessonPlan = LessonManager.getLessonManager().getLessonPresets()[indexPath.row]
            content = lessonPlan.lessonName
            if homeworkEditing?.lesson?.lessonName == lessonPlan.lessonName {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            break
        case .Player:
            let player = self.users[indexPath.row]
            content = player.name
//            print(content)
//            if homeworkEditing?.instructorAssigned?.elementsEqual(player.getUID()) ?? false {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
            break
        default:
            break
        }
        
        cell.configureCell(withString: content)
        
        return cell
        
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch source {
        case .LessonPlan:
            
            let lessonPlanSelected = LessonManager.getLessonManager().getLessonPresets()[indexPath.row]
            
            if let homework = homeworkEditing {
                if let currentLessonPlan = homework.lesson {
                    for drill in homework.drills as! [Drill] {
                        for lessonDrill in currentLessonPlan.drills as! [Drill] {
                            if lessonDrill.name == drill.name {
                                homework.drills.remove(drill)
                            }
                        }
                    }
                }
                
                if (homework.lesson?.lessonName == lessonPlanSelected.lessonName) {
                    homework.lesson = nil
                } else {
                    for drill in lessonPlanSelected.drills as! [Drill] {
                        for homeworkDrill in homework.drills as! [Drill] {
                            if homeworkDrill.name == drill.name {
                                break
                            }
                        }
                        homework.drills.add(drill)
                    }
                    homework.lesson = lessonPlanSelected
                }
            }
            delegate?.updatedLessonPlan()
            break
        case .Drills:
            let drill = DrillManager.getDrillManager().getDrills()[indexPath.row]
            
            for homeworkDrill in homeworkEditing?.drills as! [Drill] {
                if drill.name == homeworkDrill.name {
                    homeworkEditing?.drills.remove(drill)
                    return
                }
            }
            homeworkEditing?.drills.add(drill)
            delegate?.updatedDrills()
            break
        case .Player:
            let playerSelected = users[indexPath.row]
            //let success = HomeworkManager.getHomeworkManager().changeStudent(newID: playerSelected.getUID(), forHomework: homeworkEditing!)
            
//            if !success {
//                let nameConflict = AlertUtil.generateAlertViewController(withTitle: "Name Conflict", withMessage: "This player already has homework with this name", withStyle: .alert, actions: [AlertUtil.doneAction])
//                self.present(nameConflict, animated: true, completion: nil)
//            }
//            
            delegate?.updatedDrills()
        default:
            break
        }
        
        tableView.reloadData()
    }

    
}

enum HomeworkManipSource {
    case LessonPlan
    case Drills
    case Player
}

protocol HomeworkManipDelegate {
    
    func updatedDrills()
    func updatedLessonPlan()
    
}
