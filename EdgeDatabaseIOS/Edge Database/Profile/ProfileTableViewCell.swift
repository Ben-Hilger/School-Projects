//
//  ProfileTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 11/6/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class ProfileTableViewCell : UITableViewCell {
    
    @IBOutlet var label : UILabel!
    
    var identifier : String!
    
    func setupCell(str : String, id : String) {
        label.text = str
        identifier = id
    }
    
    
}
