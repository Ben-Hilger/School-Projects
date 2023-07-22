//
//  TeamRosterCoachTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/10/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamRosterCoachTableViewCell : UITableViewCell {
    
    @IBOutlet var profileImage : UIImageView!
    @IBOutlet var name : UILabel!

    func configureCell(forUser user : User) {
        profileImage.image = UIImage()
        name.text = user.name
    }
    
}
