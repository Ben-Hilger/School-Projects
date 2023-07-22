//
//  SportTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/25/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class SportTableViewCell : UITableViewCell {
    
    @IBOutlet var sportLabel : UILabel!
    
    
    func configureCell(sport : String) {
        sportLabel.text = sport
    }
}
