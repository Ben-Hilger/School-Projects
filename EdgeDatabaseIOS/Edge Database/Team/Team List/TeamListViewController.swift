//
//  TeamListViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/8/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamListViewController : UITableViewController {
    
    var teams : [String : String]  = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCellInformation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCellInformation()
    }
    
    func loadCellInformation() {
        teams = [:]
        let teamCodes = UserManager.getUserManager().getUser().teamCodes as? [String] ?? []
        for teamCode in teamCodes {
            FirebaseTeams.instance.loadTeamName(forTeamCode: teamCode) { (name, teamCode) in
                self.teams.updateValue(teamCode, forKey: name)
                print(name)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addTeam() {
        let code = FirebaseTeams.instance.generateTeamCode()
        let team = TeamManager.instance.getTeamFromTeamCode(tc: code)
        self.performSegue(withIdentifier: "teamInfo", sender: team)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "teamInfo" {
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamInfo") as! TeamListTableViewCell
        
        cell.configureCell(withTeam: teams.keys.sorted()[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamSelected = teams[teams.keys.sorted()[indexPath.row]] ?? ""
        let optionsAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Please select an option below", withStyle: .alert)
        let viewTeam = UIAlertAction(title: "View Team", style: .default) { (action) in
            FirebaseTeams.instance.loadTeam(teamCode: teamSelected) { (team) in
                TeamManager.instance.teamEditing = team
                print("HERERERE")
                self.performSegue(withIdentifier: "teamInfo", sender: nil)
            }
        }
        optionsAlert.addAction(viewTeam)
        optionsAlert.addAction(AlertUtil.cancelAction)
        self.present(optionsAlert, animated: true, completion: nil)
    }
    
     @IBAction func openMenu(sender : Any) {
           (SidebarLauncher(delegate: self)).show()
    }
}


extension TeamListViewController : SideBarDelegate {
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
}
