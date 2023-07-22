//
//  LessonPresetsViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/28/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit
import SharedCode

class LessonPlanViewController: UITableViewController, LessonDrillDelegate, UIPopoverPresentationControllerDelegate {
    // Controls the add leeson plan button on the top right corner of the navigation bar
    @IBOutlet var addButton : UIButton!
    // Outlet that manages the title of the navigation bar
    @IBOutlet var lessonTitle : UINavigationItem!
    // Stores the Lesson Preset that is being viewed
    var lessonPlanViewing : Lesson!
    // Stores the original lesson preset, only used if Firebase if offline and/or changes must be disregarded
    var orig : Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Hides and disables the add lesson plan button, as this is researved for coaches
            addButton.isEnabled = false
            addButton.isHidden = true
        }
        // Sets the title of the navigationbar to the name of the lesson preset using
        lessonTitle.title = lessonPlanViewing.lessonName
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Updates the backup lesson preset to the current to the one being shown
        orig = lessonPlanViewing
        // Reloads the tableview data
        tableView.reloadData()
    }

    // MARK: - Table View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of drills in the lesson preset
        return lessonPlanViewing.drills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieves the cell from the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrillDetail") as! LeftDetailTableViewCell
        // Configures the cell with the drill name
        cell.configureCell(withString: "\((lessonPlanViewing.drills[indexPath.row] as! Drill).name)")
        // Returns the configured cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the title of the tableview header
        return "Drills Included"
    }
    
    @IBAction func addDrill(sender : Any) {
        // Directs the user to the view responsible showing all of the drills
        self.performSegue(withIdentifier: "showDrills", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks if the user is going to the showDrills view
        if segue.identifier?.elementsEqual("showDrills") ?? false  {
            // Stores the view that shows all of the drills
            let destination = segue.destination as! LessonPlanDrillViewController
            // Stores the view that shows the drills in this lesson preset (this class)
            let prev = sender as! LessonPlanViewController
            // Sets the delegate
            destination.delegate = prev
        }
    }
    
    // MARK: Delegate Functions
    
    func drillSelected(drill: Drill, completion: (Bool) -> ()) {
         
        // Checks if the selected drill  is already within the drill set
        for lessonDrill in lessonPlanViewing.drills as! [Drill]{
            // Checks if the lesson drill's name is equal to the drill selected
            if lessonDrill.name == drill.name {
                // Removes the drill from the lesson plan
                lessonPlanViewing.drills.remove(lessonDrill)
                // Reloads the tableview
                tableView.reloadData()
                // Calls the callback with false to indicate removal
                completion(false)
                // Stops the function
                return
            }
        }
        // Adds the drill to the lesson plan
        lessonPlanViewing.drills.add(drill)
        // Reloads the tableview
        tableView.reloadData()
        // Calls the callback with true to indicate add
        completion(true)
     }
    
    func done() {
        // Dismisses the drill popover
        self.dismiss(animated: true, completion: nil)
        // Reloads the tableview
        self.tableView.reloadData()
    }
    
    // MARK: - Popover Presentation Delegate Functions
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func isWithinLessonPreset(drill: Drill) -> Bool {
        // Explores the drills in the lesson plan
        for currentDrill in lessonPlanViewing.drills as? [Drill] ?? [] {
            // Checks if the current drill's name is equal to the selected drill
            if currentDrill.name == drill.name {
                // Returns true since the drill is in the lesson plan
                return true
            }
        }
        // Returns false since the drill wasn't found
        return false
    }
    
    @IBAction func backToLessonPlan() {
        // Checks to make sure a valid team is being edited
        if let team = TeamManager.instance.teamEditing, let lessonNumber = lessonPlanViewing.lessonNumber, UserManager.getUserManager().getUser().accountType == AccountType.coach {
            // Attempts to save the specified lesson plan
            FirebaseLesson.instance.saveLesson(lessonToSave: lessonPlanViewing, lesson_number: Int(truncating: lessonNumber), forTeam: team.teamCode) { (success) in
                if success {
                    // Takes the user back to the lessons page
                    self.performSegue(withIdentifier: "backToLessons", sender: self)
                } else {
                    // Creates an alert to notify the user of the faliure to save
                    let failureToSave = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "There was an issue savign your changes, so any changes made may not be saved", withStyle: .alert)
                    // Creates an action for the user to move on
                    let done = UIAlertAction(title: "Done", style: .default) { (action) in
                        // Takes the user back to the lessons page
                        self.performSegue(withIdentifier: "backToLessons", sender: self)
                    }
                    // Adds the done action to the alert
                    failureToSave.addAction(done)
                    // Presents the failure
                    self.present(failureToSave, animated: true, completion: nil)
                }
            }
        } else {
            // Takes the user back to the lessons page
            self.performSegue(withIdentifier: "backToLessons", sender: self)
        }
       
    }
    
    
}
