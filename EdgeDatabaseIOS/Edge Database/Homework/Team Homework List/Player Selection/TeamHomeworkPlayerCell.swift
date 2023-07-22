//
//  TeamHomeworkPlayerCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamHomeworkPlayerCell : UITableViewCell {
    // Controls the label seen by the user on the view
    @IBOutlet var label : UILabel!
    
    func configureCell(forPlayer player : String) {
        // Sets the text of the label to the players username
        label.text = player
    }
}
