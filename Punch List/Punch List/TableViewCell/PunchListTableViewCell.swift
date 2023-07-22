//
//  PunchListTableViewCell.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class PunchListTableViewCell : UITableViewCell {
    
    @IBOutlet var item : UILabel!
    @IBOutlet var date : UILabel!
    
    func configureCell(forItem i : PunchItem) {
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 2
        
        item.text = i.getItem()
        date.text = dateToString(d: i.getDueDate())
    }
    
    func dateToString(d : Date) -> String {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        return formatter.string(from: d)
    }
    
}
