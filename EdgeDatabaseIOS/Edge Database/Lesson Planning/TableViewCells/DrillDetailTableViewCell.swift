//
//  DrillDetailTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/8/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class DrillDetailTableViewCell : UITableViewCell {
    
    @IBOutlet var mainLabel : UILabel!
    @IBOutlet var detailLabel : UILabel!
    
    func setupCell(forMain m : String, forDetail d : String) {
        mainLabel.text = m
        detailLabel.text = d
    }
    
    
}
