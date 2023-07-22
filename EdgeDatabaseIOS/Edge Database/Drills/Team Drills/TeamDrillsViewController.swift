//
//  TeamDrillsViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/16/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamDrillsViewController : UITableViewController {
    // Stores the drills being viewed
    var drills : [Drill] = []
    // Outlet that controls the add button
    @IBOutlet var addButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Hides the add button since it's researved for coaches
            addButton.isHidden = true
            addButton.isEnabled = false
        }
        // Configures the view
        configureView()
    }
    
    func configureView() {
        // Gets the drills from the drill manager
        self.drills = DrillManager.getDrillManager().getDrills()
        // Reloads the tableview data
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Configures the view
        configureView()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of drills
        return drills.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the current drill
        let drill = drills[indexPath.row]
        // Gets the cell and configures it
        let cell : TeamDrillTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamDrill") as! TeamDrillTableViewCell
        cell.configureCell(forDrill: drill)
        // Returns the cell to be used
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the drill selected
        let drill = drills[indexPath.row]
        // Generates an alert to give the user options to interact with the drill
        let optionAlert = AlertUtil.generateAlertViewController(withTitle: "Drill Options", withMessage: nil, withStyle: .actionSheet)
        // Creates an action to view the drill information
        let viewDrillDetail = UIAlertAction(title: "View Details", style: .default) { (action) in
            self.performSegue(withIdentifier: "toDrillInformation", sender: drill)
        }
        // Adds the drill action to the optionAlert
        optionAlert.addAction(viewDrillDetail)
        // Adds the cancel action to the optionAlert
        optionAlert.addAction(AlertUtil.cancelAction)
        // Presents the optionAlert to the user
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the title of the drill
        return "Drills"
    }
    
    @IBAction func addDrill(sender : Any) {
        // Generates an alert to set the new drill name
        let newDrillAlert = AlertUtil.generateAlertViewController(withTitle: "Add Drill", withMessage: "Please enter the name of the drill below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Drill Name Here..."])
        let done = UIAlertAction(title: "Add", style: .default) { (action) in
            if let text = newDrillAlert.textFields?[0].text {
                if text != "" {
                    // Attempts to add the new drill
                    let drill = DrillManager.getDrillManager().addDrill(withName: text)
                    // Takes the user to the drill infromation page
                    self.performSegue(withIdentifier: "toDrillInformation", sender: drill)
                } else {
                    // Presents the alert indicating to the user they didn't enter valid input
                    self.present(AlertUtil.generateAlertViewController(withTitle: "Adding Drill", withMessage: "Please enter a valid drill name", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                }
                
            }
        }
        newDrillAlert.addAction(done)
        // Presents the new drill alert
        self.present(newDrillAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks if there's valid input
        if let id = segue.identifier {
            // Checks if the user is going to the drill information page
            if id == "toDrillInformation", let drill = sender as? Drill {
                // Configures the drill detail view controller
                if let destination = segue.destination as? DrillDetailViewController {
                    destination.drillToView = drill
                    destination.canChange = UserManager.getUserManager().getUser().accountType == AccountType.coach
                }
            }
        }
    }
}

extension TeamDrillsViewController : SideBarDelegate {
    func sidebarDidOpen() {}
    
    func sidebarDidClose(with item: Int?) {}
    
    @IBAction func openMenu(sender : Any) {
        (SidebarLauncher(delegate: self)).show()
    }
}
