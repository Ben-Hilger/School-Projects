//
//  CategoryTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/8/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class CategoryTableViewCell : UITableViewCell {
    
    @IBOutlet var categoryName : UILabel!
    
    func setupCell(forString c : String) {
        
        categoryName.text = c
        
    }
    
}
