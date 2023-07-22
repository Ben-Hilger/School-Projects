//
//  TeamInformationViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/8/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamInformationViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var teamLogo : UIImage!
    @IBOutlet var teamName : UILabel!
    
    @IBOutlet var tableView : UITableView!
    
    var info : [TeamInformationCell] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        FormatUtil.formatLabel(textView: teamName)
        populateCells()
        
    }
    
    func populateCells() {
        info = []
    //TODO: Add Logo support
        if let team = TeamManager.instance.teamEditing {
            teamName.text = team.displayName
            
            let user = UserManager.getUserManager().getUser()
            
            if let email = team.email, email != "" {
                info.append(TeamInformationCell(label: "Email:", message: email))
            } else if user.accountType == AccountType.coach {
                info.append(TeamInformationCell(label: "Email:", message: "Set the email"))
            } else {
                info.append(TeamInformationCell(label: "Email:", message: "No set email"))
            }
            
            if let owner = team.owner, owner != "" {
                print("\(owner) - \(team.users.count)")
                for user in team.users as? [User] ?? [] {
                    if user.uid == owner {
                        info.append(TeamInformationCell(label: "Owner:", message: user.username))
                    }
                }
            } else if user.accountType == AccountType.coach {
                info.append(TeamInformationCell(label: "Owner:", message: "Set the owner of the team"))
            } else {
                info.append(TeamInformationCell(label: "Owner:", message: "No set owner of this team"))
            }
        
            if let loc = team.location, loc != "" {
      
                info.append(TeamInformationCell(label: "Location:", message: loc))
            } else if user.accountType == AccountType.coach {
                info.append(TeamInformationCell(label: "Location:", message: "Set the location of the team"))
            } else {
                info.append(TeamInformationCell(label: "Location:", message: "No location set for this team"))
            }
            
            if let website = team.website, website != "" {
                info.append(TeamInformationCell(label: "Website:", message: website))
            } else if user.accountType == AccountType.coach {
                info.append(TeamInformationCell(label: "Website:", message: "Enter a link to your website"))
            } else {
                info.append(TeamInformationCell(label: "Website:", message: "No website link for this team"))
            }
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TeamInformationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformationCell") as! TeamInformationTableViewCell
        
        cell.configureCell(withLabel: info[indexPath.row].getLabel(), withMessage: info[indexPath.row].getMessage())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamCellSelected : TeamInformationCell = info[indexPath.row]
        // Checks to ensure the user has the necessary permissions
        if UserManager.getUserManager().getUser().accountType != AccountType.coach {
            return
        }
        
        if teamCellSelected.getLabel() == "Owner:" {
            if let team = TeamManager.instance.teamEditing {
                if team.owner == UserManager.getUserManager().getUser().uid || team.owner == "" {
                    let optionsAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Select ", withStyle: .actionSheet)
                    let changeOwner = UIAlertAction(title: "Change Owner", style: .default) { (action) in
                        let changeOwnerAlert = AlertUtil.generateAlertViewController(withTitle: "Change Owner", withMessage: "Please enter the username of the new owner below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter username of new owner..."])
                        let changeAction = UIAlertAction(title: "Done", style: .default) { (action) in
                            if let username = changeOwnerAlert.textFields?[0].text {
                                var found = false
                                for user in team.users as? [User] ?? [] {
                                    print("Username \(user.username)")
                                    if user.username == username {
                                        let prevOwner = team.owner
                                        team.owner = user.uid
                                        FirebaseTeams.instance.saveTeamInfo(team: team) { (success) in
                                            if success {
                                                self.present(AlertUtil.generateAlertViewController(withTitle: "Changed Owner", withMessage: "The owner has been changed successfully!", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                                                self.populateCells()
                                                self.tableView.reloadData()
                                            } else {
                                                team.owner = prevOwner
                                                self.present(AlertUtil.generateAlertViewController(withTitle: "Changing Owner", withMessage: "There was an issue changing the owner, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                                            }
                                        }
                                        found = true
                                        break
                                    }
                                }
                                if !found {
                                    self.present(AlertUtil.generateAlertViewController(withTitle: "Changing Owner", withMessage: "There was no user on the team with the desired username, please make sure you entered it correct", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                                }
                                
                            }
                        }
                        changeOwnerAlert.addAction(changeAction)
                        self.present(changeOwnerAlert, animated: true, completion: nil)
                    }
                    optionsAlert.addAction(changeOwner)
                    self.present(optionsAlert, animated: true, completion: nil)
                } else if team.owner != "" {
                    let insufficientPermAlert = AlertUtil.generateAlertViewController(withTitle: "Insufficent Permissions", withMessage: "You must be the owner to change this field", withStyle: .alert, actions: [AlertUtil.doneAction])
                    self.present(insufficientPermAlert, animated: true, completion: nil)
                }
            }
        } else {
            let item = teamCellSelected.getLabel().lowercased().replacingOccurrences(of: ":", with: "")
            let changeAlert = AlertUtil.generateAlertViewController(withTitle: "Change", withMessage: "Please enter the new \(item)", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter new \(item)"])
            let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
                if let text = changeAlert.textFields?[0].text {
                    if text == "" {
                        return
                    } else if let team = TeamManager.instance.teamEditing {
                        var prevItem = ""
                        if item == "email" {
                            prevItem = team.email ?? ""
                            team.email = text
                        } else if item == "location" {
                            prevItem = team.location ?? ""
                            team.location = text
                        } else if item == "website" {
                            prevItem = team.website ?? ""
                            team.website = text
                        }
                        print(item)
                        FirebaseTeams.instance.saveTeamInfo(team: team) { (success) in
                            if success {
                                self.present(AlertUtil.generateAlertViewController(withTitle: "Change \(item)", withMessage: "The \(item) was changed successfully!", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                                self.populateCells()
                                self.tableView.reloadData()
                            } else {
                                if item == "email" {
                                    team.email = prevItem
                                } else if item == "location" {
                                    team.location = prevItem
                                } else if item == "website" {
                                    team.website = prevItem
                                }
                                self.present(AlertUtil.generateAlertViewController(withTitle: "Change \(item)", withMessage: "There was an issue changing \(item), please try agan later", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            changeAlert.addAction(doneAction)
            self.present(changeAlert, animated: true, completion: nil)
        }
    }
}


struct TeamInformationCell {
    
    private var label : String
    private var message : String
    
    init(label : String, message : String) {
        self.label = label
        self.message = message
    }
    
    func getLabel() -> String {
        return label
    }
    
    func getMessage() -> String {
        return message
    }
}

extension TeamInformationViewController : SideBarDelegate {
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
