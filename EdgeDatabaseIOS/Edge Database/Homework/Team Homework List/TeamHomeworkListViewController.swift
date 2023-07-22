//
//  TeamHomeworkMenuViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit
import SharedCode

class TeamHomeworkListViewController : UITableViewController {
    // Stores the homework loaded from Firebase
    var sortedHomework : [Homework] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configures the cells information
        configureCellInformation()
    }

    // MARK: - Table View Information Configuration
    
    func configureCellInformation() {
        // Loads all of the available homework
        HomeworkManager.getHomeworkManager().loadHomework() { (homework) in
            // Sets the homework to the array loaded
            self.sortedHomework = homework
            // Reloads the tableview
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of homework
        return sortedHomework.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the appropriate cell from the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell", for: indexPath) as! TeamHomeworkListCell
        // Gets the current homework
        let homework : Homework = sortedHomework[indexPath.row]
        // Configures the cell with the specified homework
        cell.configureCell(forHomework: homework.name)
        // Returns the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the title of the tableview section
        return "Homework"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the homework the user selected
        let homeworkSelected = sortedHomework[indexPath.row]
        // Generates an option alert to allow the user to interact with the homework
        let optionsAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Please select an option below", withStyle: .actionSheet, actions: [AlertUtil.cancelAction])
        // Creates an action to take the user to the homework details
        let viewDetails = UIAlertAction(title: "View Details", style: .default) { (action) in
            self.performSegue(withIdentifier: "addHomework", sender: homeworkSelected)
        }
        // Creates an action to allow the user to assign a player to the homework
        let assignTo = UIAlertAction(title: "Assign to...", style: .default) { (action) in
            self.performSegue(withIdentifier: "toPlayerSelected", sender: homeworkSelected)
        }
        // Adds the view details action to the options alert
        optionsAlert.addAction(viewDetails)
        // Checks if the user is a coach
        if UserManager.getUserManager().getUser().accountType == AccountType.coach {
            // Adds the assignTo alert action to the options alert
            optionsAlert.addAction(assignTo)
        }
        // Presents the option alert to the user
        self.present(optionsAlert, animated: true, completion: nil)
    }

    @IBAction func addHomework(sender : Any) {
        // Generates an alert to prompt the user to add a new homework
        let enterName = AlertUtil.generateAlertViewController(withTitle: "Add Homework", withMessage: "Please enter the name of the homework below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Name Here..."])
        // Creates a new action to allow the user to create the specified homework
        let done = UIAlertAction(title: "Done", style: .default) { (action) in
            // Checks to ensure there's a valid textfield
            if let text = enterName.textFields?[0].text {
                // Attempts to create the homework or gets the homework if it alreadt exists
                let result = HomeworkManager.getHomeworkManager().addHomework(withName: text)
                // Takes the user to the homework information view
                self.performSegue(withIdentifier: "addHomework", sender: result)
            }
        }
        // Adds the done action to the enterName alert
        enterName.addAction(done)
        // Presents the enterName alert to the user
        self.present(enterName, animated: true, completion: nil)
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks if the user is going to the homework information view
        if segue.identifier == "addHomework" {
            // Gets the destination view
            let destination = segue.destination as! ViewHomeworkViewContoller
            // Sets the homework that is being viewed
            destination.homeworkViewing = sender as? Homework
        } else if segue.identifier == "toPlayerSelected" { // Checks if the user is going to the assign homework view
            // Gets the destination view
            let destination = segue.destination as! TeamHomeworkPlayerSelection
            // Sets the homework that is being assigned
            destination.homework = sender as? Homework
        }
    }
    
    @IBAction func openMenu(sender : Any) {
        // Presents the navigation sidebar
        (SidebarLauncher(delegate: self)).show()
    }
    
}

// MARK: - Navigation SideBar 
extension TeamHomeworkListViewController : SideBarDelegate {
    func sidebarDidOpen() {}
    
    func sidebarDidClose(with item: Int?) {}
}
