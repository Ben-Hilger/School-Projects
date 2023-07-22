//
//  PunchItemCreationViewContoller.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/29/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class PunchItemCreationViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet var itemDesp : UITextField!
    
    @IBOutlet var categoryOptions : UIPickerView!
    var categories : [String] = []
    var selectedCategory : String = "No Category"
    @IBOutlet var otherDesp : UITextField!
    
    @IBOutlet var dueDate : UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = PunchListManager.getPunchListManager().getCategories()
        
        categoryOptions.delegate = self
        categoryOptions.dataSource = self
        
        otherDesp.isHidden = true
        
        categoryOptions.layer.borderColor = UIColor.black.cgColor
        categoryOptions.layer.borderWidth = 1
        dueDate.layer.borderColor = UIColor.black.cgColor
        dueDate.layer.borderWidth = 1
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        if selectedCategory == "Other" {
            otherDesp.isHidden = false
        } else {
            otherDesp.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    @IBAction func cancel(sender : Any) {
        
        self.performSegue(withIdentifier: "backToList", sender: self)
        
    }
    
    @IBAction func createItem(sender : Any) {
        
        if let text = itemDesp.text {
            if text == "" {
                return
            }
            
            if selectedCategory == "Other" && otherDesp.text != "" {
                selectedCategory = otherDesp.text!
            } else if selectedCategory == "Other" && otherDesp.text == "" {
                return
            }
            
            if selectedCategory == "Selected Category" {
                return
            }
            
            let category = Category(n: selectedCategory)
            
            let item : PunchItem = PunchItem(i: text, cat: category, dD: dueDate.date)
            
            PunchListManager.getPunchListManager().addPunchItem(item: item)
         
            FirestoreManager.getFirestoreManager().savePunchList()
            
            self.performSegue(withIdentifier: "backToList", sender: self)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        itemDesp.endEditing(true)
        otherDesp.endEditing(true)
    }
}
