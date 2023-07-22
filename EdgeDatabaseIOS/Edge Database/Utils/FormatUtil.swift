//
//  FormatUtil.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class FormatUtil {
    
    static func formatButton(forButton b : UIButton) {
        b.layer.borderColor = UIColor.blue.cgColor
        b.layer.borderWidth = 1
    }
    
    static func arrayToString(forArr : [String]) -> String {
        var str = ""
        
        for index in 0..<forArr.count {
            str += forArr[index] + (index != forArr.count-1 ? "," : "")
        }
        
        return str
    }
    
    static func formatPicker(forPicker dp : UIPickerView) {
        
        dp.layer.borderColor = UIColor.blue.cgColor
        dp.layer.borderWidth = 1
        
    }
    
    static func formatDatePicker(forDatePicker dp : UIDatePicker) {
        
        dp.layer.borderColor = UIColor.blue.cgColor
        dp.layer.borderWidth = 1
        
    }
    
    static func formatLabel(textView : UILabel) {
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1 
    }
    
}
