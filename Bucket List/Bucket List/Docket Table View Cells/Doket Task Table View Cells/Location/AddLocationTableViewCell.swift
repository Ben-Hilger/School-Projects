//
//  AddLocationTableViewCell.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/29/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class AddLocationTableViewCell : UITableViewCell {
    
    var vc : CreateReminderViewController?
    
    @IBAction func addLocation(sender : Any){
        let alert = UIAlertController(title: "Set Location", message: "Please enter the address below", preferredStyle: .alert)
    
        alert.addTextField { (field) in
            field.placeholder = "Enter location..."
        }
    
        let change = UIAlertAction(title: "Set Location", style: .default) { (action) in
            if let text = alert.textFields![0].text, let viewController = self.vc {
               viewController.location = text
            }
        }
    
        alert.addAction(UIAlertAction(title: "Canecl", style: .cancel, handler: nil))
        alert.addAction(change)
    
    }
    
    
}
