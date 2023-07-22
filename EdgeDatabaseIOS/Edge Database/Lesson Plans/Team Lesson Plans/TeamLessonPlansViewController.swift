//
//  TeamLessonPlansViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/18/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamLessonViewController : UITableViewController {
    // Controls the add lesson plan button on the view
    @IBOutlet var addButton : UIButton!
    // Stores the lessons of the team
    var lessonPlans : [Lesson] = []
    
    override func viewDidLoad() {
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Hides and disables the add button since it's reserved for coaches
            addButton.isHidden = true
            addButton.isEnabled = false 
        }
        // Configures the tableview
        configureView()
        super.viewDidLoad()
    }
    
    func configureView() {
        // Sets the lesson plans
        self.lessonPlans = LessonManager.getLessonManager().lessonPlans
        // Reloads the tableview
        self.tableView.reloadData()
        
    }
    
    // MARK: - TableView Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of lesson plans
        return lessonPlans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the cell from the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonCell") as! TeamLessonPlanTableViewCell
        // Configures the cell with the lesson plans
        cell.configureCell(forLesson: lessonPlans[indexPath.row])
        // Returns the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the lesson plan selected by the user
        let lessonSelected = lessonPlans[indexPath.row]
        // Creates an action to allow the user to view the lesson plan's information
        let goToInfoAction = UIAlertAction(title: "View Information", style: .default) { (action) in
            // Takes the user to the lesson information view
            self.performSegue(withIdentifier: "toLessonInformation", sender: lessonSelected)
        }
        // Generates an alert to allow the user to interact with the selected lesson plan
        let optionAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Please select an option below", withStyle: .actionSheet, actions: [goToInfoAction, AlertUtil.cancelAction])
        // Presents the option alert to the user
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the lesson plans section title
        return "Lesson Plans"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks if the identifier exists
        if let id = segue.identifier {
            // Checks if the id indicates the user is going to view the lesson plan info
            if id == "toLessonInformation", let lesson = sender as? Lesson {
                // Gets the destination view
                if let destination = segue.destination as? LessonPlanViewController {
                    // Sets the lesson to the lesson plan viewing
                    destination.lessonPlanViewing = lesson
                }
            }
        }
    }
    
    @IBAction func addLessonPlan(sender : Any) {
        // Generates an alert to set the new drill name
        let newLessonAlert = AlertUtil.generateAlertViewController(withTitle: "Add Lesson Plan", withMessage: "Please enter the name of the lesson plan below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Lesson Plan Name Here..."])
        let done = UIAlertAction(title: "Add", style: .default) { (action) in
            if let text = newLessonAlert.textFields?[0].text {
                if text != "" {
                    // Attempts to add the new drill
                    let lesson = LessonManager.getLessonManager().addLesson(withName: text)
                    // Takes the user to the drill infromation page
                    self.performSegue(withIdentifier: "toLessonInformation", sender: lesson)
                } else {
                    // Presents the alert indicating to the user they didn't enter valid input
                    self.present(AlertUtil.generateAlertViewController(withTitle: "Adding Lesson Plan", withMessage: "Please enter a valid lesson plan name", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                }
                
            }
        }
        newLessonAlert.addAction(done)
        // Presents the new drill alert
        self.present(newLessonAlert, animated: true, completion: nil)
    }
}

// MARK: - Navigation SideBar

extension TeamLessonViewController : SideBarDelegate {
    func sidebarDidOpen() {}
    
    func sidebarDidClose(with item: Int?) {}
    
    @IBAction func openMenu(sender : Any) {
        (SidebarLauncher(delegate: self)).show()
    }
}
