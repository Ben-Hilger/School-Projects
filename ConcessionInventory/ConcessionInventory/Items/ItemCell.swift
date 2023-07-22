//
//  ItemCell.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/19/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class ItemCell : UITableViewCell {
    
    @IBOutlet var name : UILabel!
    @IBOutlet var count : UILabel!
    
    func setItem(item : Item){
        name.text = item.getName()
        count.text = "Count: \(item.getCount())"
    }
    
}
