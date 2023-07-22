//
//  DrillDetailStaticTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/9/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit

class DrillDetailStaticTableViewCell: UITableViewCell {
    // Outlet that controls the left detail label
    @IBOutlet var main : UILabel!
    // Outlet that controlss the right detail label
    @IBOutlet var category : UILabel!

    func setupCell(forMain m : String, forCategory d : String) {
        // Sets the labels with the appropriate text
        category.text = d
        main.text = m
    }    
}
