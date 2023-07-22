//
//  TeamListTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/9/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamListTableViewCell : UITableViewCell {
    
    @IBOutlet var teamName : UILabel!
    
    func configureCell(withTeam team : String) {
        teamName.text = team
    }
}
