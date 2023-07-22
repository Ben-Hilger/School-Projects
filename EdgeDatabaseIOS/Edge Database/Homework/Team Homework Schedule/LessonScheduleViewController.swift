//
//  LessonScheduleViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/7/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class LessonScheduleViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, SideBarDelegate {
    // Stores the tableview instance
    @IBOutlet var tableView : UITableView!
    // Stores the sorted homework assignments
    var sorted : [String : [Homework]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the tableview delegate and datasource to this file
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Generates an activity alert to inform the user that the information is loading
        let alert = AlertUtil.generateActivityAlert(withMessage: "Loading Information...")
        // Presents the activity alert to the user
        self.present(alert, animated: true) {
            // Organizies the information of the tableview cell
            self.sortTableViewCells() {
                // Reloads the tableview information
                self.tableView.reloadData()
                // Removes the activity alert
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
        
    func sortTableViewCells(completion : @escaping () -> ()) {
        // Clears the current sorted homework
        sorted = [:]
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Loads the assigned homeworks of the player
            HomeworkManager.getHomeworkManager().loadAssignedHomeworks(playerUsername: UserManager.getUserManager().getUser().uid) { (allHomework) in
                print(allHomework)
                // Goes through the downloaded assignments
                for homework in allHomework {
                    // Gets the due date of the current homewokr
                    let dueDate = homework.dueTime
                    // Sets the specified key
                    let key = "Due: \(dueDate)"
                    // Gets a list of the current homework with the same key
                    var currentHomeworkDate = self.sorted[key] ?? []
                    // Adds the homework to the list
                    currentHomeworkDate.append(homework)
                    // Updatees the sorted list with the new homework list
                    self.sorted.updateValue(currentHomeworkDate, forKey: key)
                }
                // Now finished, it calls the callback
                completion()
            }
        } else {
            // Loads all of homework assignments
            HomeworkManager.getHomeworkManager().loadMassAssignedHomework { (sort) in
                // Sets the sorted list
                self.sorted = sort
                // Now finished, it calls the callback
                completion()
            }
        }
    }
    
    @IBAction func addHomework(sender : Any) {
        // Generates an alert to prompt the user to enter the name of the user
        let enterName = AlertUtil.generateAlertViewController(withTitle: "Add Homework", withMessage: "Please enter the name of the homework below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Name Here..."])
        // Creates a done action that adds the homework
        let done = UIAlertAction(title: "Done", style: .default) { (action) in
            // Checks if theres a valid text field
            if let text = enterName.textFields?[0].text {
                // Attempts to add the homework, or gets the homework with the same name if it exists
                let result = HomeworkManager.getHomeworkManager().addHomework(withName: text)
                // Takes the user to the homework information page
                self.performSegue(withIdentifier: "addHomework", sender: result)
                
            }
            
        }
        // Adds the done action to the enterName alert
        enterName.addAction(done)
        // Presents the alert to the user
        self.present(enterName, animated: true, completion: nil)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Gets the destination controller
        let des = segue.destination as! ViewHomeworkViewContoller
        // Sets the homework to the one viewing
        des.homeworkViewing = sender as? Homework
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Returns the number of sections
        return sorted.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of homework assignments for that section
        return sorted[sorted.keys.sorted()[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the appropriate homework cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Homework") as! HomeworkDateTableViewCell
        // Configures the cell
        cell.configureCell(forHomework: sorted[sorted.keys.sorted()[indexPath.section]]![indexPath.row])
        //  Returns the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the homework the user selected
        let homeworkSelected = sorted[sorted.keys.sorted()[indexPath.section]]![indexPath.row]
        // Generates an alert that allows the user to interact with the selected homework
        let optionsAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Please select an option below", withStyle: .actionSheet, actions: [AlertUtil.cancelAction])
        // Creates an alert to view the homework details
        let viewDetails = UIAlertAction(title: "View Details", style: .default) { (action) in
            // Takes the user to the homework information view with the specified homework
            self.performSegue(withIdentifier: "addHomework", sender: homeworkSelected)
        }
        // Creastes an alert to mark it as complete
        let markAsCompleted = UIAlertAction(title: "Mark as Complete", style: .default) { (action) in
            // Calls the method to mark the homework as completed
            HomeworkManager.getHomeworkManager().markAsCompleted(forHomework: homeworkSelected) { (success) in
                // Checks if it was successfull
                if success {
                    // Resorts the table view cells
                    self.sortTableViewCells {
                        // Reloads the table vie
                        self.tableView.reloadData()
                    }
                } else {
                    // Presents an alert notifying the user that
                    self.present(AlertUtil.generateAlertViewController(withTitle: "Marking Complete", withMessage: "There was an issue processing your request, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                }
            }
        }
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Adds the mark as completed action
            optionsAlert.addAction(markAsCompleted)
        }
        // Adds the view  details action
        optionsAlert.addAction(viewDetails)
        // Presents the alert to the user
        self.present(optionsAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Returns the sorted key at the specifid section
            return sorted.keys.sorted()[section]
        }
        // Gets the uid of the user
        let uid = sorted.keys.sorted()[section]
        // Gets the current team being viewed
        if let team = TeamManager.instance.teamEditing {
            // Explores the users list
            for user in team.users as? [User] ?? [] {
                // Checks if the user's uid is equal
                print("\(user.uid) - \(uid)")
                if user.uid.elementsEqual(uid) {
                    // Returns the user's username
                    return user.username
                }
            }
        }
        return "Unknown Player"
    }
    
    @IBAction func back(sender : Any) {
        // Presents the side-bar navigation
        (SidebarLauncher(delegate: self)).show()
    }
    
    func sidebarDidOpen() {}
    
    func sidebarDidClose(with item: Int?) {}
}
