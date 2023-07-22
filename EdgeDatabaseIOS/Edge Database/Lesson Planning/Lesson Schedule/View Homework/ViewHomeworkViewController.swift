//
//  AddHomeworkViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/6/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class ViewHomeworkViewContoller : UIViewController, UITableViewDelegate, UITableViewDataSource, DatePickerDelegate, UIPopoverPresentationControllerDelegate, HomeworkManipDelegate {


    var homeworkViewing : Homework?
    
    @IBOutlet var  homeworkTitle :  UINavigationItem!
    
    @IBOutlet var tableView : UITableView!
    
    var datePickerIndex : IndexPath?
    
    var sorted : [String : [Any]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let homework = homeworkViewing {
            homeworkTitle.title =  homework.name
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.sortTableViewCells()
        
    }
    
    func sortTableViewCells() {
        self.sorted = [:]
        
        if let homework = self.homeworkViewing {
            
            let dueDate = DateUtil.stringToDate(string: homework.dueTime) ?? Date()
            let startDate = DateUtil.stringToDate(string: homework.startTime) ?? Date()
            self.sorted.updateValue([startDate, dueDate], forKey: self.Date_Key)
            
            print(homework.drills.count)
            
            if homework.drills.count > 0 {
                self.sorted.updateValue(homework.drills as! [Drill], forKey: self.Additional_Drills_Selected_Key)
            } else {
                self.sorted.updateValue([], forKey: self.Additional_Drills_Selected_Key)
            }
            
            if let plan = homework.lesson {
                self.sorted.updateValue([plan], forKey: self.Lesson_Plan_Key)
            } else {
                self.sorted.updateValue([], forKey: self.Lesson_Plan_Key)
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sorted.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        var count = sorted[sorted.keys.sorted()[section]]?.count ??  0
        
        if datePickerIndex != nil, sorted.keys.sorted()[section].elementsEqual(Date_Key) {
            count += 1
        }
        
        if sorted.keys.sorted()[section].elementsEqual(Additional_Drills_Selected_Key), sorted[Additional_Drills_Selected_Key]!.count >= 1 && UserManager.getUserManager().getUser().accountType == AccountType.coach {
            count += 1
        }
    
        if count == 0 && UserManager.getUserManager().getUser().accountType == AccountType.coach {
            count = 1
        }
        
        print("Count \(count)")
        
        return count
        
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if datePickerIndex == indexPath {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Date_Key) as! DatePickerTableViewCell
            
            cell.delegate = self
            cell.datePicker.date = datePickerIndex?.row == 1 ? DateUtil.stringToDate(string: homeworkViewing!.startTime) ?? Date() : DateUtil.stringToDate(string: homeworkViewing!.dueTime) ?? Date()
            
            return cell
            
        } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Date_Key) {
            let cell =  tableView.dequeueReusableCell(withIdentifier: Left_Detail_Identifier) as! LeftDetailTableViewCell
            
            let formatter = DateFormatter()
            formatter.dateFormat =  "MMMM dd, YYY, HH:mm"

            if indexPath.row == 0 {
                cell.configureCell(withString: "Start: \(formatter.string(from: sorted[Date_Key]![0] as! Date))")
                //cell.configureCell(forLeftDetail: "Homework Start Date:", forRightDetail: formatter.string(from: sorted["Date"]![0] as! Date))
            } else {
                cell.configureCell(withString: "Due: \(formatter.string(from: sorted[Date_Key]![1] as! Date))")
                //cell.configureCell(forLeftDetail: "Homework Due Date:", forRightDetail: formatter.string(from: sorted["Date"]![1] as! Date))
            }
            
            
            return cell
        } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Additional_Drills_Selected_Key) {
            
            if sorted[Additional_Drills_Selected_Key]!.count+1 == indexPath.row+1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: Left_Detail_Identifier) as! LeftDetailTableViewCell
                
                cell.configureCell(withString: Add_Additional_Drills_Label)

                return cell
                
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Left_Detail_Identifier) as! LeftDetailTableViewCell
            let drill : Drill = sorted[Additional_Drills_Selected_Key]![indexPath.row] as! Drill
            
            cell.configureCell(withString: drill.name)
            
            return cell
        }
            
            
            
        } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Lesson_Plan_Key) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Left_Detail_Identifier) as! LeftDetailTableViewCell
            
            cell.configureCell(withString: homeworkViewing?.lesson?.lessonName ?? Add_Lesson_Plan_Label)
            
            return cell
        } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Player_Selected_Key) {

           let cell = tableView.dequeueReusableCell(withIdentifier: Left_Detail_Identifier) as! LeftDetailTableViewCell

           var content : String = Add_Player_Label
           
//           if (homeworkViewing?.playerAssigned) != nil {
//               content = sorted[Player_Selected_Key]![0] as? String ?? Add_Player_Label
//           }
           cell.configureCell(withString: content)
           
           return cell
        } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Instuctor_Selected_Key) {

           let cell = tableView.dequeueReusableCell(withIdentifier: Left_Detail_Identifier) as! LeftDetailTableViewCell

           var content : String = Add_Player_Label
           
            if (homeworkViewing?.instructorAssigned) != nil {
               content = sorted[Instuctor_Selected_Key]![0] as? String ?? "Unknown"
           }
           cell.configureCell(withString: content)
           
           return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("\(section)   \(sorted.keys.sorted().count)")
        return sorted.keys.sorted()[section]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            return
        }
        
        tableView.beginUpdates()
        
        if sorted.keys.sorted()[indexPath.section].elementsEqual(Lesson_Plan_Key) || sorted.keys.sorted()[indexPath.section].elementsEqual(Additional_Drills_Selected_Key) || sorted.keys.sorted()[indexPath.section].elementsEqual(Player_Selected_Key) {
            
            let cell = tableView.cellForRow(at: indexPath) as! LeftDetailTableViewCell
            
            if sorted.keys.sorted()[indexPath.section].elementsEqual(Lesson_Plan_Key) {
                self.performSegue(withIdentifier: "toManipulate", sender: [Lesson_Plan_Key, cell])
            } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Additional_Drills_Selected_Key), cell.leftDetail.text?.elementsEqual(Add_Additional_Drills_Label) ?? false {
                self.performSegue(withIdentifier: "toManipulate", sender: [Add_Additional_Drills_Label, cell])
            } else if sorted.keys.sorted()[indexPath.section].elementsEqual(Player_Selected_Key) {
                self.performSegue(withIdentifier: "toManipulate", sender: [Add_Player_Label, cell])
            }
            
        } else if let datePickerIndexPath = datePickerIndex,   datePickerIndexPath.row - 1 == indexPath.row {
           tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
           self.datePickerIndex = nil
        } else {
           if let datePickerIndexPath = datePickerIndex {
              tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
           }
            
            if sorted.keys.sorted()[indexPath.section].elementsEqual(Date_Key) {
                datePickerIndex = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndex!], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        tableView.endUpdates()
        
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndex, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    func dateChanged(newDate d: Date) {
        
        if let dateIndex = datePickerIndex {
            
            // Start
            if dateIndex.row == 1 {
                homeworkViewing?.startTime = DateUtil.dateToString(date: d)
                
                if let homework = homeworkViewing {
                    if (DateUtil.stringToDate(string: homework.dueTime)?.compare(DateUtil.stringToDate(string: homework.startTime) ?? Date()).rawValue ?? 0) < 0 {
                        homework.dueTime = homework.startTime
                    }
                }
            } else if dateIndex.row == 2 {
                homeworkViewing?.dueTime = DateUtil.dateToString(date: d)
                
                if let homework = homeworkViewing {
                    if (DateUtil.stringToDate(string: homework.startTime)?.compare(DateUtil.stringToDate(string: homework.dueTime) ?? Date()).rawValue ?? 0) > 0 {
                        homework.startTime = homework.dueTime
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.sortTableViewCells()
            self.tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.elementsEqual("toManipulate") ?? false {
            let key = (sender as! [Any])[0] as! String
            
            if key.elementsEqual(Lesson_Plan_Key) {
                let des = segue.destination as! HomeworkManipViewController
                des.delegate = self
                des.source = .LessonPlan
               
                des.modalPresentationStyle = .popover
                des.popoverPresentationController?.sourceView = (sender as! [Any])[1] as! LeftDetailTableViewCell
                des.popoverPresentationController?.delegate = self
                des.homeworkEditing = homeworkViewing
            } else if key.elementsEqual(Add_Additional_Drills_Label) {
                let des = segue.destination as! HomeworkManipViewController
                 des.delegate = self
                 des.source = .Drills
                
                 des.modalPresentationStyle = .popover
                 des.popoverPresentationController?.sourceView = (sender as! [Any])[1] as! LeftDetailTableViewCell
                 des.popoverPresentationController?.delegate = self
                 des.homeworkEditing = homeworkViewing
            } else if key.elementsEqual(Add_Player_Label) {
                let des = segue.destination as! HomeworkManipViewController
                 des.delegate = self
                des.source = .Player
                
                 des.modalPresentationStyle = .popover
                 des.popoverPresentationController?.sourceView = (sender as! [Any])[1] as! LeftDetailTableViewCell
                 des.popoverPresentationController?.delegate = self
                 des.homeworkEditing = homeworkViewing
            }
        } else if segue.identifier?.elementsEqual("toComments") ?? false {
            let des = segue.destination as! CommentsViewController
            des.homeworkViewing = homeworkViewing
        }
        
    }
    
    func updatedDrills() {
        DispatchQueue.main.async {
            self.sortTableViewCells()
        }
        
    }
    
    func updatedLessonPlan() {
        DispatchQueue.main.async {
            self.sortTableViewCells()
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func next(sender : Any) {
        
//        if homeworkViewing?.playerAssigned == nil {
//            return
//        }
        
        self.performSegue(withIdentifier: "toComments", sender: nil)
    }
    
    final let Date_Key = "Date"
    final let Additional_Drills_Selected_Key = "Drills Selected"
    final let Lesson_Plan_Key = "Lesson Plan"
    final let Player_Selected_Key = "Assigned Player"
    final let Instuctor_Selected_Key = "Assigned Instructor"
    
    final let Date_TableView_Identifier = "Date"
    final let Date_Picker_Cell_Identifier = "DateCell"
    final let Left_Detail_Identifier = "LeftDetail"
    
    final let Add_Lesson_Plan_Label = "Click Here to Add a Lesson Plan"
    final let Add_Additional_Drills_Label = "Click Here to Add Additional Drills"
    final let Add_Player_Label = "Click Here to Select a Player to Assign"
}
