//
//  WorkOutViewController.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class WorkOutViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var label : UILabel!
    @IBOutlet var tableView : UITableView!
    
    let workOut : WorkOut = WorkOut(d: "Monday")
    
    var day : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let index = Calendar.current.component(.weekday, from: Date())-1 == -1 ? DateFormatter().weekdaySymbols.count-1 : Calendar.current.component(.weekday, from: Date())-1
        
        day = DateFormatter().weekdaySymbols[index]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd,yyyy"
        
        label.text = day + ", " + formatter.string(from: Date())
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workOut.workOutElements[day]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : WorkOutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Workout") as! WorkOutTableViewCell

        cell.configureCell(lab: workOut.workOutElements[day]![indexPath.row])
        
        return cell
        
    }
    
}
