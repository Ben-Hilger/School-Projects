//
//  DatePickerTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/6/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class DatePickerTableViewCell : UITableViewCell {
    
    @IBOutlet var datePicker : UIDatePicker!
    
    var delegate : DatePickerDelegate?
    
    func configureCell(withDate d : Date?)  {
        
        if let date = d {
            datePicker.date = date
        }
    }
    
    @IBAction func valueChanged(sender : Any) {
        delegate?.dateChanged(newDate: datePicker.date)
    }
}

protocol DatePickerDelegate {
    
    func dateChanged(newDate d : Date)
    
}
