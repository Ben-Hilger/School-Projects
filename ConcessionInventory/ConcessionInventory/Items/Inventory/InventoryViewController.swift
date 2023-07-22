//
//  InventoryViewController.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class InventoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    static var inventoryDates : [InventoryDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.loadInventoryDates { (dates) in
            InventoryViewController.inventoryDates = dates
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InventoryViewController.inventoryDates.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Inventory") as! InventoryCell
        cell.addDate(d: InventoryViewController.inventoryDates[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let dateChoosen = InventoryViewController.inventoryDates[indexPath.row]
        ViewController.inventoryDate = dateChoosen
        self.performSegue(withIdentifier: "DisplayInven", sender: self)
    }
    
    @IBAction func addInventory(sender : Any){
        let id = InventoryDate(d: Date(), i: [])
        ViewController.inventoryDate = id
        self.performSegue(withIdentifier: "DisplayInven", sender: self)
    }
}
