//
//  DetailedItemCell.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class DetailedItemCell : UITableViewCell {
    
    @IBOutlet var name : UILabel!
    
    func addItem(d : Item){
        name.text = d.getName() + ": \(d.getCount())" 
    }
    
}
