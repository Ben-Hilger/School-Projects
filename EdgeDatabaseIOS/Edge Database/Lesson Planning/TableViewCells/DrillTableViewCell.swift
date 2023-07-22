//
//  DrillTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/5/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class DrillTableViewCell : UITableViewCell {
    
    @IBOutlet var drillName : UILabel!
    
    func setupCell(forDrill d : Drill) {
        drillName.text = d.name
    }
    
    
}
