//
//  TeamHomeworkListCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit

class TeamHomeworkListCell: UITableViewCell {
    // Controls the label seen by the user on the cell
    @IBOutlet var label : UILabel!
    
    func configureCell(forHomework homework : String) {
        // Sets the text of the label to the name of the homework
        label.text = homework
    }

}
