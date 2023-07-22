//
//  ListTableViewCell.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/27/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewCell : UITableViewCell {
    
    @IBOutlet var itemNum : UILabel!
    @IBOutlet var descrip : UILabel!
    
    func configureCell(number : Int, item : ListItem) {
        descrip.text = item.descrip
    }
}
