//
//  TeamRosterTableViewCEll.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/9/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamRosterTableViewCell : UITableViewCell {
    // Controls the profile image of the user in the cell
    @IBOutlet var profileImage : UIImageView!
    // Controls the name of the user in the cell
    @IBOutlet var name : UILabel!
    // Controls the position of the user in the cell
    @IBOutlet var position : UILabel!
    // Controls the number of the user in the cell
    @IBOutlet var number : UILabel!
    
    func configureCell(forUser user : User) {
        // Sets the appropriate fields for the specified user
        profileImage.image = UIImage()
        name.text = user.name
        position.text = ""
        number.text = ""
    }
    
}
