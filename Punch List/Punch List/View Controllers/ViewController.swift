//
//  ViewController.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    var punchListItems : [PunchItem] = []

    var sortedItems : [String : [PunchItem]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        
        FirestoreManager.getFirestoreManager().loadPunchList { (items) in
            PunchListManager.getPunchListManager().setPunchList(items: items)
            self.sort()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sort()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedItems.keys.sorted()[section] ?? "No Category"
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        var selectedPunchItem : PunchItem = sortedItems[sortedItems.keys.sorted()[indexPath.section]]![indexPath.row]
        
        let alert = UIAlertController(title: "Task Update", message: "Please select from the following options below to edit/change the sleected task", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let completed : UIAlertAction = UIAlertAction(title: "Task Completed", style: .default) { (action) in
            
            let alert2 = UIAlertController(title: "Day Completed", message: "Please select the day below when this task was completed", preferredStyle: .alert)
            
            let dayCompleted : UIAlertAction = UIAlertAction(title: "Today", style: .default, handler: { (action2) in
                
                selectedPunchItem.setCompletionDate(d: Date())
    
            })
    
            alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert2.addAction(dayCompleted)
            
            self.present(alert2, animated: true, completion: nil)
            
        }
        
        alert.addAction(completed)

        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedItems[sortedItems.keys.sorted()[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "punchItem") as! PunchListTableViewCell
        
        cell.configureCell(forItem: sortedItems[sortedItems.keys.sorted()[indexPath.section]]![indexPath.row])
        
        return cell
    }
    
    func sort() {
        
        punchListItems = PunchListManager.getPunchListManager().getPunchList()
        sortedItems = [:]
        
        for item in punchListItems {
            
            var array : [PunchItem] = sortedItems[item.getCategory().getName()] ?? []
            array.append(item)
            
            sortedItems.updateValue(array, forKey: item.getCategory().getName())
            
        }
        
    }
    
    @IBAction func addItem(sender : Any) {
        self.performSegue(withIdentifier: "toCreate", sender: self)
    }
    
}

