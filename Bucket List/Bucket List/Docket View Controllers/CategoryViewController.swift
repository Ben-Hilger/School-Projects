//
//  CategoryViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categoryName : String = ""
    var categoryItems : [DocketTaskFramework] = []
    
    @IBOutlet var taskName : UILabel!
    @IBOutlet var taskTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.reloadData()
        
        taskName.text = categoryName
    }
    
    @IBAction func addTask(sender : Any){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DocketTaskTableViewCell = taskTableView.dequeueReusableCell(withIdentifier: "Category") as! DocketTaskTableViewCell
    
        cell.setupTask(task: categoryItems[indexPath.row])
        
        return cell
    
    }

    
    
}
