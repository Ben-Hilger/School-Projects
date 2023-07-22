//
//  AddTaskDateCell.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class AddTaskDateCell : UITableViewCell {
    
    @IBOutlet var date : UILabel!
    
    func addDate(d : String){
        date.text = d
    }
    
}
