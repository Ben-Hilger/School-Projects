//
//  WorkOutTableViewCell.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class WorkOutTableViewCell : UITableViewCell {
    
    @IBOutlet var label : UILabel!
    
    func configureCell (lab : WorkoutItem) {
        label.text = "\(lab.name) \(lab.numOfReps) x \(lab.numberPerReps[0])"
    }
    
    
}
