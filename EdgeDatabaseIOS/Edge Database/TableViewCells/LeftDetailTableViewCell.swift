//
//  LeftDetailTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/14/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit

class LeftDetailTableViewCell: UITableViewCell {

    @IBOutlet var leftDetail : UILabel! // Outlet that manages the left content viewed
    
    /**
            Configures the cell, setting the left detail to the speciifed string
     */
    func configureCell(withString : String) {
        leftDetail.text = withString // Sets the leftDetail text to the string specified
    }
    
}
