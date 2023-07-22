//
//  TeamInformationCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/8/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class TeamInformationTableViewCell : UITableViewCell {
    
    @IBOutlet var label : UILabel!
    @IBOutlet var message : UILabel!
    
    func configureCell(withLabel label : String, withMessage mess : String) {
        self.label.text = label
        self.message.text = mess
    }
}
