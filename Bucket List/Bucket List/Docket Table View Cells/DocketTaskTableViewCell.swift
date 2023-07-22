//
//  BucketListTaskCell.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class DocketTaskTableViewCell : UITableViewCell {
    
    @IBOutlet var name : UILabel!
    
    func setupTask(task : DocketTaskFramework){
        name.text = task.getName()

    }
}
