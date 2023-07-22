//
//  DetailedItemViewController.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/26/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class DetailedItemViewController : UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    @IBOutlet var tableView : UITableView!
    
    var dItems : [DetailedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.loadInventoryDates { (dates) in
            self.dItems = self.getItemsFromDates(dates: dates)
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dItems.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Inventory") as! DetailedItemCell
        cell.addItem(d: dItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let dateChoosen = InventoryViewController.inventoryDates[indexPath.row]
        ViewController.inventoryDate = dateChoosen
        self.performSegue(withIdentifier: "DisplayInven", sender: self)
    }
    
    func getItemsFromDates(dates : [InventoryDate]) -> [DetailedItem] {
        var items : [DetailedItem] = []
        for index in 0..<dates.count {
            for index2 in 0..<dates[index].item.count {
                if(items.contains(DetailedItem(name: dates[index].item[index2].getName()))){
                    let item : DetailedItem = items[items.index(of: DetailedItem(name: dates[index].item[index2].getName()))!]
                    item.mergeWithItem(item: dates[index].item[index2], d: dates[index].getDateasString())
                }else{
                    let newItem = DetailedItem(name: dates[index].item[index2].getName())
                    newItem.mergeWithItem(item: dates[index].item[index2], d: dates[index].getDateasString())
                    items.append(newItem)
                }
            }
        }
        return items
    }
}
