//
//  TeamInvitesTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/23/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamInvitesTableViewCell : UITableViewCell {
    // Outlet that controls the team name label
    @IBOutlet var teamName : UILabel!
    
    func configureCell(forTeam name : String) {
        // Sets the team name
        teamName.text = name
    }
    
}
