//
//  TeamDrillTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/16/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamDrillTableViewCell : UITableViewCell {
    // Controls the label of the tableViewCell
    @IBOutlet var drillLabel : UILabel!
    // Stores the drill being represented by this cell
    var drill : Drill?
    
    func configureCell(forDrill drill : Drill) {
        // Sets the name of the cell
        drillLabel.text = drill.name
        // Sets the drill
        self.drill = drill
    }
}
