//
//  TeamRosterTableViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/10/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamRosterTableViewController : UITableViewController {
    // Stores the users of the team being used
    var users : [User] = []
    // Stores the sorted users
    var sorted : [String : [User]] = [:]
    // Controls the invite button on the view
    @IBOutlet var inviteButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configures the view
        configureView()
    }
    
    func configureView() {
        // Checks if the user is a player
        if UserManager.getUserManager().getUser().accountType == AccountType.player {
            // Hides the invite button since it's researved for coaches
            inviteButton.isHidden = true
            inviteButton.isEnabled = false
        }
        // Checks if there's a valid team being edited
        if let team = TeamManager.instance.teamEditing {
            // Sets the user list
            users = team.users as! [User]
            // Sorts the users
            sort()
            // Reloads the tableview data
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sorted.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Checks if it's the coaches or players section
        if section == 0 {
            return "Coaches"
        } else {
            return "Players"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of user in the specified section
        return sorted[sorted.keys.sorted()[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Checks if the current section is a coach
        if indexPath.section == 0 && users[indexPath.row].accountType == AccountType.coach {
            // Gets the coachCell from the tableview
            let cell : TeamRosterCoachTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoachCell") as! TeamRosterCoachTableViewCell
            // Gets the current user
            let user = sorted[sorted.keys.sorted()[indexPath.section]]?[indexPath.row]
            // Configures the cell with the specified user
            cell.configureCell(forUser: user!)
            // Returns the cell
            return cell
        } else {
            // Gets the playercell from the tableview
            let cell : TeamRosterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! TeamRosterTableViewCell
            // Gets the current user
            let user = sorted[sorted.keys.sorted()[indexPath.section]]?[indexPath.row]
            // Configure the cell with the specified user
            cell.configureCell(forUser: user!)
            // Returns the cell
            return cell
        }
    }
    
    func sort() {
        // Clears the sorted list
        sorted = [:]
        // Stores the coaches and users
        var coaches : [User] = []
        var players : [User] = []
        // Explores the user list
        for user in users {
            // Checks if the user is a coach
            if user.accountType == AccountType.coach {
                // Adds the coach to the coach list
                coaches.append(user)
            } else {
                // Adds the player to the player list
                players.append(user)
            }
        }
        // Sets the sorted list with the sorted array's
        sorted = [
            "Coaches" : coaches,
            "Players" : players
        ]
    }
    
    @IBAction func invitePlayer(sender : Any) {
        // Generates an alert to allow the person to invite a new player
        let enterNameAlert = AlertUtil.generateAlertViewController(withTitle: "Invite Player", withMessage: "Enter the username of the usser you would like to invite below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Username..."])
        // Generates an alert action to invite the player to the 
        let inviteAction = UIAlertAction(title: "Invite", style: .default) { (action) in
            if let username = enterNameAlert.textFields?[0].text {
                if let team = TeamManager.instance.teamEditing {
                    FirebaseUser.getFirebaseAccount().inviteUser(toTeam: team.teamCode, withUsername: username) { (success) in
                        if success {
                            let successAlert = AlertUtil.generateAlertViewController(withTitle: "Invite Player", withMessage: "The player with the entered username has been invited to the team, check with them to have them accept it", withStyle: .alert, actions: [AlertUtil.doneAction])
                            self.present(successAlert, animated: true, completion: nil)
                        } else {
                            let failureAlert = AlertUtil.generateAlertViewController(withTitle: "Invite Player", withMessage: "There was an error inviting the player, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                            self.present(failureAlert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        enterNameAlert.addAction(inviteAction)
        self.present(enterNameAlert, animated: true, completion: nil)
    }
}

extension TeamRosterTableViewController : SideBarDelegate {
    func sidebarDidOpen() {
        print("Sidebar Opened")
    }
    
    func sidebarDidClose(with item: Int?) {
        guard let item = item else {return}
        print("Did select \(item)")
        switch item {
        case 0: // Profile, which is already showing
            break
        default:
            break
        }
    }
    
    @IBAction func openMenu(sender : Any) {
        (SidebarLauncher(delegate: self)).show()
    }
}
