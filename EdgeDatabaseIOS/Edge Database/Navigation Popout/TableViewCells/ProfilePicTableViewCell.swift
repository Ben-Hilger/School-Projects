//
//  ProfilePicTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 11/17/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class ProfilePicTableViewCell : UITableViewCell {
    
    @IBOutlet var profilePic : UIImageView!
    @IBOutlet var instructorCode : UILabel!
    
    func configureCell(forUser u : User) {
    }
    
}
