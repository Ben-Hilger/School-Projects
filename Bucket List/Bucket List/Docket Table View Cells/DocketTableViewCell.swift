//
//  BucketListTableViewControllerCell.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class DocketTableViewCell : UITableViewCell {
    
    @IBOutlet var name : UILabel!
    @IBOutlet var date : UILabel!
    @IBOutlet var catCount : UILabel!
    @IBOutlet var taskCount : UILabel!
    
    func setupBucketList(b : Docket) {
        name.text = b.getNameOfList()
        date.text = b.getReadableDate()
        catCount.text = "\(b.getNumberofCategories())"
        taskCount.text = "\(b.getNumberOfTasks())"
    }
    
}
