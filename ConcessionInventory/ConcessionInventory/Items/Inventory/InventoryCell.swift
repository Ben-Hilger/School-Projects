//
//  InventoryCell.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class InventoryCell : UITableViewCell {
    
    @IBOutlet var date : UILabel!
    
    func addDate(d : InventoryDate){
        date.layer.borderColor = UIColor.black.cgColor
        date.layer.borderWidth = 1
        let form = DateFormatter()
        form.dateFormat = "MM/dd/yyyy"
        date.text = form.string(from: d.date)
    }
}
