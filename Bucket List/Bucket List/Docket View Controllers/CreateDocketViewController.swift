//
//  CreateBucketListViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class CreateDocketViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var name : UITextField!
    @IBOutlet var generalDescription : UITextView!
    @IBOutlet var targetDate : UIDatePicker!
    
    @IBOutlet var categoryTableView : UITableView!
    
    var categories : [String : [DocketTaskFramework]] = [:]
    var docketController : DocketViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalDescription.layer.borderWidth = 2
        generalDescription.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func addCategory(sender : Any){
        let alert = UIAlertController(title: "Create New Category", message: "Please enter the new category name below", preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter new category name..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let action = UIAlertAction(title: "Add New Category", style: .default) { (a) in
            if let textField : UITextField = alert.textFields![0] {
                if(!self.categoryAlreadyExists(cat: textField.text!)){
                    self.categories.updateValue([], forKey: textField.text!)
                    let alert2 = UIAlertController(title: "Category Created", message: "A new category with the given name has been created", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert2, animated: true, completion: nil)
                }else{
                    let alert2 = UIAlertController(title: "Category Already Exists", message: "The category entered already exists, please enter a new unique name", preferredStyle: .alert)
                    alert2.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert2, animated: true, completion: nil)
                }
            }
        }
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addTask(sender : Any){
        let button : UIButton = sender as! UIButton
        let cat = button.description
    
        AddTaskToCategoryViewController.categoryToAddTo = cat
    
        self.performSegue(withIdentifier: "addTask", sender: self)
        
    }
    
    func viewCategory(name : String){
        let view : CategoryViewController = storyboard?.instantiateViewController(withIdentifier: "categoryView") as! CategoryViewController
        view.categoryName = name
        view.categoryItems = categories[name]!
        self.present(view, animated: true, completion: nil)
    }
    
    
    @IBAction func createBucketList(sender : Any){
        let finalBucketList : Docket = Docket(n: name.text!, genDes: generalDescription.text!, targetD: targetDate.date)
        if let dc = docketController {
            dc.bucketList.append(finalBucketList)
            self.present(dc, animated: true, completion: nil)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories.keys.sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.keys.sorted()[section].count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DocketTaskTableViewCell = categoryTableView.dequeueReusableCell(withIdentifier: "category") as! DocketTaskTableViewCell
    
        cell.setupTask(task: categories[categories.keys.sorted()[indexPath.section]]![indexPath.row])
        return cell
    }
    
    func categoryAlreadyExists(cat : String) -> Bool {
        for key in categories.keys.sorted() {
            if key == cat {
                return true
            }
        }
        
        return false
    }

}
