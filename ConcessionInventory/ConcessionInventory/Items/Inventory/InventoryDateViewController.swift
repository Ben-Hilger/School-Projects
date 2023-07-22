//
//  InventoryDateViewController.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class InventoryDateViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    static var inventoryDate : InventoryDate?
    
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let id = InventoryDateViewController.inventoryDate {
            return id.item.count
        }else{
            return 0
        }
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item") as! ItemCell
        if let id = InventoryDateViewController.inventoryDate {
            cell.setItem(item: id.item[indexPath.row])
        }
        
        return cell
    }
}
