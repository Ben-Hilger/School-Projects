//
//  HomeworkDateTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/28/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class HomeworkDateTableViewCell : UITableViewCell {
    
    @IBOutlet var homeworkName : UILabel!
    @IBOutlet var studentAssigned : UILabel!
    @IBOutlet var numberOfDrills : UILabel!
    @IBOutlet var numberOfComments : UILabel!
    
    func configureCell(forHomework hw: Homework) {
        // Sets the label to the homework name
        homeworkName.text = hw.name
        // Stores the number of drills in the homework
        var numOfDrills = hw.drills.count
        // Explores the Drills in the homework lessons plan, if one is found
        for drill in (hw.lesson?.drills as? [Drill] ?? []) {
            // Checks if the homework contains the drill or not
            if !hw.drills.contains(drill) {
                // Adds one to the total number of drills
                numOfDrills += 1
            }
        }
        // Sets the label to display the number of drills
        numberOfDrills.text = "\(numOfDrills) Drill\(numOfDrills != 1 ? "s" : "")"
        // Sets the label to display the number of comments
        numberOfComments.text = "\(hw.comments.count) Comment\(hw.comments.count != 1 ? "s" : "")"
    }
    
    
    
}
