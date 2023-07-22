//
//  AddTaskToCategoryViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 12/22/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class AddTaskToCategoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var taskName : UILabel!
    @IBOutlet var des: UILabel!

    @IBOutlet var potentialDate : UIDatePicker!
    @IBOutlet var dateTableView : UITableView!
    var dates : [Date] = []
    
    @IBOutlet var location : UILabel!
    
    static var categoryToAddTo : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPotentialDate(sender : Any){
        dates.append(potentialDate.date)
        dateTableView.reloadData()
    }
    
    @IBAction func addLocation(sender : Any) {
        
    }
    
    @IBAction func addTask(sender : Any) {
        let task : DocketTaskFramework = DocketTaskFramework(n: taskName.text!, des: des.text!, type: DocketTaskFramework.DOCKET_TYPE.REMINDER)
        for date in dates {
            task.addPotentialDate(d: date)
        }
        
        task.setLocation(loc: location.text != "" ? location.text! : "")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddTaskDateCell = dateTableView.dequeueReusableCell(withIdentifier: "dateCell") as! AddTaskDateCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.addDate(d: formatter.string(from: dates[indexPath.row]))
        
        return cell
    }

}
