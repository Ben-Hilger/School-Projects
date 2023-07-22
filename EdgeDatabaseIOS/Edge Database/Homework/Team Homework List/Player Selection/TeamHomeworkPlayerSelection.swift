//
//  TeamHomeworkPlayerSelection.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamHomeworkPlayerSelection : UITableViewController {
    // Stores the list of users being viewed
    var users : [User] = []
    // Stores the homework being viewe
    var homework : Homework?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Populates the user list
        populateUsers()
        // Reloads the tableView data
        tableView.reloadData()
        // Creates a copy of the homework
        self.homework = homework!.doCopy()
    }
    
    func populateUsers() {
        // Clears the current user list
        users = []
        // Checks to see if there's a valid team to use
        if let team = TeamManager.instance.teamEditing {
            // Goes through the list of users
            for user in team.users as? [User] ?? [] {
                // Checks if the given user is a player
                if user.accountType == AccountType.player {
                    // Adds the user to the list
                    users.append(user)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of users
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Sets the title
        return "Available Users"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the player cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as!  TeamHomeworkPlayerCell
        // Configures the cell
        cell.configureCell(forPlayer: users[indexPath.row].name)
        // Returns the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the selected user
        let user = users[indexPath.row]
        // Creates an alert to assign the player to the homework
        let assignPlayer = UIAlertAction(title: "Assign Player to Homework", style: .default) { (action) in
            // Checks if there's a valid homework
            if let homework = self.homework {
                // Generates a done action to take the user back to the homework list
                let done = UIAlertAction(title: "Done", style: .default) { (action) in
                    self.performSegue(withIdentifier: "backToHomeworkList", sender: nil)
                }
                // Assigns the homework to the player
                HomeworkManager.getHomeworkManager().assignHomeworkToPlayer(playerUsername: user.uid, coachUsername: "", forHomework: homework) { (success) in
                    // Checks if it was  successful
                    if success {
                        // Presents an alert to the user to notify them it was assigned successfully
                        self.present(AlertUtil.generateAlertViewController(withTitle: "Assigning Player", withMessage: "The player was assigned successfully", withStyle: .alert, actions: [done]), animated: true, completion: nil)
                    } else {
                        // Presents an alert to the user to notify them it wasn't assigned successfully
                        self.present(AlertUtil.generateAlertViewController(withTitle: "Assigning Player", withMessage: "There was an issue assigning the player, please try again later", withStyle: .alert, actions: [done]), animated: true, completion: nil)
                    }
                }
            }
        }
        // Generates an alert to give the user options to interact with the homework
        let optionAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Please select an option below", withStyle: .actionSheet, actions: [assignPlayer])
        // Creates a cancel action to show the optionAlert
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.present(optionAlert, animated: true, completion: nil)
        }
        // Creates an action to change the start time
        let changeStartDate = UIAlertAction(title: "Change Start Time: \(String(describing: homework!.startTime))", style: .default) { (action) in
            // Generates an alert to allow the user to change the start time
            let changeAlert = AlertUtil.generateAlertViewController(withTitle: "Change Start Time", withMessage: "Please enter the new start time below", withStyle: .alert, actions: [cancel], withTextFieldPlaceholders: ["MM-dd-yyy"])
            // Generates a set action to change the start time
            let done = UIAlertAction(title: "Set", style: .default) { (action) in
                // Checks if there's a valid text field
                if let time = changeAlert.textFields?[0].text {
                    // Attempts to create a date
                    if DateUtil.stringToDate(string: time) != nil {
                        // Sets the homework start time
                        self.homework?.startTime = time
                        // Presents the option alert
                        self.present(optionAlert, animated: true, completion: nil)
                    } else {
                        // Creates a retry action
                        let done = UIAlertAction(title: "Retry", style: .default) { _ in
                            // Presents the change alert
                            self.present(changeAlert, animated: true, completion: nil)
                        }
                        // Presents an alert informing the user the date entered was invalids
                        self.present(AlertUtil.generateAlertViewController(withTitle: "Enter a valid date", withMessage: "You entered an invalid date, please try again", withStyle: .alert, actions: [done]), animated: true, completion: nil)
                    }
                }
            }
            // Adds the done action to the change alert
            changeAlert.addAction(done)
            // Presents the change alert
            self.present(changeAlert, animated: true, completion: nil)
        }
        // Creates an action to change the due date
        let changeDueDate = UIAlertAction(title: "Change Due Time: \(String(describing: homework!.dueTime))", style: .default) { (action) in
            // Creaes an alert to enter the new date
            let changeAlert = AlertUtil.generateAlertViewController(withTitle: "Change Due Time", withMessage: "Please enter the new due time below", withStyle:
                .alert, actions: [cancel], withTextFieldPlaceholders: ["MM-dd-yyy"])
            // Creates an action to set the due date
            let done = UIAlertAction(title: "Set", style: .default) { (action) in
                // Checks if theree's a valid field
                if let time = changeAlert.textFields?[0].text {
                    // Attempts to make a date
                    if DateUtil.stringToDate(string: time) != nil {
                        // Creates a copy of the homework
                        self.homework? = self.homework?.doCopy() as! Homework
                        // Sets the due date of the homework
                        self.homework?.dueTime = time
                        // Presents the option alert
                        self.present(optionAlert, animated: true, completion: nil)
                    } else {
                        // Creates a retry  action
                        let done = UIAlertAction(title: "Retry", style: .default) { _ in
                            self.present(changeAlert, animated: true, completion: nil)
                        }
                        // Presents an alert informing the user the date entered was invalids
                        self.present(AlertUtil.generateAlertViewController(withTitle: "Enter a valid date", withMessage: "You entered an invalid date, please try again", withStyle: .alert, actions: [done]), animated: true, completion: nil)
                    }
                }
            }
            // Adds the set action to the change alert
            changeAlert.addAction(done)
            // Presents the change alert to the  user
            self.present(changeAlert, animated: true, completion: nil)
        }
        // Adds the change start date action to the option alert
        optionAlert.addAction(changeStartDate)
        // Adds the change due date action to the option alert
        optionAlert.addAction(changeDueDate)
        // Adds a cancel action to the option alert
        optionAlert.addAction(AlertUtil.cancelAction)
        // Presents the option alert to the user
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender : Any) {
        // Takes the user back to the homework list
        self.performSegue(withIdentifier: "backToHomeworkList", sender: nil)
    }
}
