//
//  ItemViewController.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/19/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    static var currentItem : Item?
    
    @IBOutlet var itemName : UILabel!
    @IBOutlet var currentAmt : UILabel!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var looseItems : UITextField!
    
    @IBOutlet var returnButton : UIButton!
    
    var counters : [CaseCounter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = ItemViewController.currentItem {
            itemName.text = item.getName()
            itemName.layer.borderWidth = 1
            itemName.layer.borderColor = UIColor.black.cgColor
            
            currentAmt.text = "Current Count: " + String(item.getCount())
            currentAmt.layer.borderWidth = 1
            currentAmt.layer.borderColor = UIColor.black.cgColor
            
            looseItems.layer.borderWidth = 1
            looseItems.layer.borderColor = UIColor.black.cgColor
            looseItems.delegate = self
            looseItems.text = (ItemViewController.currentItem!.getLooseItems() == 0 ? "" : String(ItemViewController.currentItem!.getLooseItems()))
            
            returnButton.layer.borderWidth = 1
            returnButton.layer.borderColor = UIColor.black.cgColor
            
            counters = item.getCases()
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CaseCell = tableView.dequeueReusableCell(withIdentifier: "Case") as! CaseCell
        cell.addCaseCounter(cc: counters[indexPath.row], functoRun: {
            () -> Void in
            self.updateCount()
        })
        return cell
    }
    
    @IBAction func returnToItems(sender : Any) {
        FirebaseManager.saveInventoryDate(date: ViewController.inventoryDate)

        self.performSegue(withIdentifier: "Return", sender: self)
    }
    
    @IBAction func addCaseCounter() {
        let alert = UIAlertController(title: "Add Case Counter", message: "Please enter the following information below", preferredStyle: .alert)
        
        alert.addTextField { (text) in
            text.placeholder = "Please Enter Location Name..."
        }
        
        alert.addTextField { (text) in
            text.placeholder = "Please Enter Amt Per Case..."
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let done = UIAlertAction(title: "Add", style: .default) { (action) in
            if alert.textFields![0].text! != "" && alert.textFields![1].text! != "" {
                let counter = CaseCounter(n: alert.textFields![0].text!, amt: Int(alert.textFields![1].text!)!)
                ItemViewController.currentItem?.addCase(c: counter)
                self.counters = (ItemViewController.currentItem?.getCases())!
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(done)
        
        self.show(alert, sender: true)
    }
    
    func updateCount(){
        if let c : Int = Int(looseItems.text!) {
            ItemViewController.currentItem?.updateLooseItems(li: c)
        }else{
            ItemViewController.currentItem?.updateLooseItems(li: 0)
        }
        
        currentAmt.text = "Current Count: " + String(ItemViewController.currentItem?.getCount() ?? 0)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateCount()
    }
    
}
