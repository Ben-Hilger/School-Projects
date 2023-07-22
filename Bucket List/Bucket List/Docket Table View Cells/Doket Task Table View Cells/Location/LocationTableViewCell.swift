//
//  LocationTableViewCell.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/29/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class LocationTableViewCell : UITableViewCell {
    
    @IBOutlet var location : UILabel!
    
    func setupLocation(loc : String){
        location.text = loc
    }
    
    @IBAction func changeLocaiton(sender : Any) {
        let alert = UIAlertController(title: "Change Location", message: "Please enter the new address below", preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter location..."
        }
        
        let change = UIAlertAction(title: "Change", style: .default) { (action) in
            if let text = alert.textFields![0].text {
                self.location.text = text
            }
        }
        
        alert.addAction(UIAlertAction(title: "Canecl", style: .cancel, handler: nil))
        alert.addAction(change)
        
    }
}
