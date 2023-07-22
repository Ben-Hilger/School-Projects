//
//  TeamInvitesTableViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/23/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamInvitesTableViewController : UITableViewController {
    // Stores the sorted names being viewed
    var names : [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Attempts to load the team invitations
        FirebaseUser.getFirebaseAccount().loadTeamInvitations(forUsername: UserManager.getUserManager().getUser().username) { (names) in
            // Sets the names to the one loaded
            self.names = names
            // Reloads the tableview data
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of keys
        return names.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the necessary cell from the tableview
        let cell : TeamInvitesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "teamInvites") as! TeamInvitesTableViewCell
        // Configures the cell with the respective name
        cell.configureCell(forTeam: names.keys.sorted()[indexPath.row])
        // Returns the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gets the team code selected
        if let teamcode = names[names.keys.sorted()[indexPath.row]] {
            // Gets the team name
            let teamName = names.keys.sorted()[indexPath.row]
            // Creates an alert to accept the invitation
            let acceptAlert = UIAlertAction(title: "Accept Invite", style: .default) { (action) in
                // Generates an activity alert to indicating the offer is being accepted
                let activityAlert = AlertUtil.generateActivityAlert(withMessage: "Accepting Offer...")
                // Generates an alert to inform the user if there's any error
                let errorAlert = AlertUtil.generateAlertViewController(withTitle: "Accepting Invite", withMessage: "There was an issue accepting the invite, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                // Presents the activityAlert
                self.present(activityAlert, animated: true) {
                    // Attempts to add the team to the users team
                    FirebaseUser.getFirebaseAccount().addTeamToCurrentTeamsList(forTeam: teamcode, forUsername: UserManager.getUserManager().getUser().username) { (success) in
                        // Checks if it was successfull
                        if success {
                            // Attempts to remove the team from the team invite list
                            FirebaseUser.getFirebaseAccount().removeTeamFromInviteList(forTeam: teamcode, forUsername: UserManager.getUserManager().getUser().username) { (success) in
                                // Checks if it was successfull
                                if success {
                                    // Adds the team code to the user's list
                                    UserManager.getUserManager().getUser().teamCodes.add(teamcode)
                                    // Saves the users profile
                                    FirebaseUser.getFirebaseAccount().updateProfile(withUID: UserManager.getUserManager().getUser().uid, withName: UserManager.getUserManager().getUser().name, withLoginType: UserManager.getUserManager().getUser().accountType, withTeamCodes: UserManager.getUserManager().getUser().teamCodes as! [String]) { (success) in
                                        // Changes the activity alert message
                                        activityAlert.message = "Team Added!"
                                        // Removes the team from the name list
                                        self.names.removeValue(forKey: teamName)
                                        // Reloads the tableview
                                        self.tableView.reloadData()
                                        // Dismises the activity alert
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                } else {
                                    // Dismises the activity alert
                                    self.dismiss(animated: true) {
                                        // Presents the error alert
                                        self.present(errorAlert, animated: true, completion: nil)
                                    }
                                }
                            }
                        } else {
                            // Dismises the activity alert
                            self.dismiss(animated: true) {
                                // Presents the error alert
                                self.present(errorAlert, animated: true , completion: nil)
                            }
                        }
                    }
                }
            }
            // Create an action to decline the invite
            let declineAlert = UIAlertAction(title: "Decline Invite", style: .default) { (action) in
                // Presents the activity alert indicating the offer is being declined
                self.present(AlertUtil.generateActivityAlert(withMessage: "Declining Offer..."), animated: true) {
                    FirebaseUser.getFirebaseAccount().removeTeamFromInviteList(forTeam: teamcode, forUsername: UserManager.getUserManager().getUser().username) { (success) in
                        // Checks if it was a success
                        if success {
                            // Dismisess the activity alert
                            self.dismiss(animated: true) {
                                // Presents an alert to inform the user that the error was declined
                                self.present(AlertUtil.generateAlertViewController(withTitle: "Declining Invite", withMessage: "The team has been removed successfully", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                            }
                        } else {
                            // Dismisess the activity alert
                            self.dismiss(animated: true) {
                                // Presents an alert to inform the user that there was an erorr while declining the alert
                                self.present(AlertUtil.generateAlertViewController(withTitle: "Declining Invite", withMessage: "There was an issue declining the invite, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            // Creates an alert to give the user options to interact with the selected team
            let optionAlert = AlertUtil.generateAlertViewController(withTitle: "Team Invitations", withMessage: "Please select an option below", withStyle: .alert, actions: [acceptAlert, declineAlert, AlertUtil.cancelAction])
            // Presents the option alert to the user
            self.present(optionAlert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func openMenu(sender : Any) {
        // Presents the navigation sidebar
        (SidebarLauncher(delegate: self)).show()
    }
    
    @IBAction func refreshInvitations(sender : Any) {
        // Presents an alert to indicate to the user that the list is refreshing
        self.present(AlertUtil.generateActivityAlert(withMessage: "Refreshing List..."), animated: true) {
            // Attempts to download the team invitations
            FirebaseUser.getFirebaseAccount().loadTeamInvitations(forUsername: UserManager.getUserManager().getUser().username) { (names) in
                // Sets the names of the teams
                self.names = names
                // Reloads the tableview
                self.tableView.reloadData()
                // Dismisess the activity alert
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension TeamInvitesTableViewController : SideBarDelegate {
    func sidebarDidOpen() { }
    
    func sidebarDidClose(with item: Int?) {}
    
}
