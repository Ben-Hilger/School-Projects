//
//  CreateReminderViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/29/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class CreateReminderViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let LOCATION_TABLE_VIEW_CELL_DEQEUE = "Location"
    let ADD_LOCATION_TABLE_VIEW_CELL_DEQEUE = "Add_Location"

    var type : DocketTaskFramework.DOCKET_TYPE = DocketTaskFramework.DOCKET_TYPE.REMINDER
    
    var categoryListToAdd : [DocketTaskFramework]?
    
    @IBOutlet var taskName : UITextField!
    @IBOutlet var des : UITextView!
    
    @IBOutlet var dateOfReminder : UIDatePicker!
    
    @IBOutlet var tableView : UITableView!
    
    var location : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    @IBAction func createTask(sender : Any){
        let task : DocketTaskFramework = DocketTaskFramework(n: taskName.text!, des: des.text!, type: type)
        
        if categoryListToAdd != nil {
            categoryListToAdd!.append(task)
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            if let loc = location {
                let cell : LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: LOCATION_TABLE_VIEW_CELL_DEQEUE) as! LocationTableViewCell
                cell.setupLocation(loc: loc)
                return cell
            }else{
                let cell : AddLocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: ADD_LOCATION_TABLE_VIEW_CELL_DEQEUE) as! AddLocationTableViewCell
                cell.vc = self
                return cell
            }
           
        }
        
        return UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    
    
}
