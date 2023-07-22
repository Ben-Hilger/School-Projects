//
//  CenterDetailTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class CenterDetailTableViewCell : UITableViewCell {
    
    @IBOutlet var centerDetail : UILabel!
    
    func configureCell(withDetail str : String) {
        centerDetail.text = str
    }
    
}
