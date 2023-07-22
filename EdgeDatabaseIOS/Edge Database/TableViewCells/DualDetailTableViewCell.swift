//
//  DualDetailTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/6/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class DualDetailTableViewCell : UITableViewCell {
    
    @IBOutlet var leftDetail  : UILabel!
    @IBOutlet var rightDetail : UILabel!
    
    func configureCell(forLeftDetail lD: String, forRightDetail rD: String) {
        leftDetail.text = lD
        rightDetail.text = rD
    }
    
    
    
    
}
