//
//  ViewController.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/19/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var tableView : UITableView!
    @IBOutlet var searchBar : UISearchBar!
    
    static var inventoryDate : InventoryDate!
    
    static var items : [Item] = []
    
    var filteredItems : [Item] = []
    
    var isSearching : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ViewController.items = []
        
        if let id = ViewController.inventoryDate {
            ViewController.items = id.item
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            return filteredItems.count
        }
        print(ViewController.items.count)
        return ViewController.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItemCell = tableView.dequeueReusableCell(withIdentifier: "Item") as! ItemCell
        if(isSearching){
            cell.setItem(item: filteredItems[indexPath.row])
        }else {
            cell.setItem(item: ViewController.items[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isSearching){
            ItemViewController.currentItem = filteredItems[indexPath.row]
        }else{
            ItemViewController.currentItem = ViewController.items[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "DisplayItem", sender: self)

    }
    
    @IBAction func addItem(sender : Any) {
        let alert = UIAlertController(title: "Add Item", message: "Please Enter the Item Name Below", preferredStyle: .alert)
        alert.addTextField { (text) in
            text.placeholder = "Enter Item Name..."
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let done = UIAlertAction(title: "Done", style: .default) { (action) in
            if alert.textFields![0].text! != "" {
                let item = Item(name: alert.textFields![0].text!)
                ViewController.inventoryDate.item.append(item)
                ItemViewController.currentItem = item
                FirebaseManager.saveInventoryDate(date: ViewController.inventoryDate)
                self.performSegue(withIdentifier: "DisplayItem", sender: self)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(done)
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func returnToInventoryScreen(sender : Any) {
        self.performSegue(withIdentifier: "ReturnInv", sender: self)
    }
    
    func filteredContentForSearchText(_ searchText : String, scope : String = "All") {
        filteredItems = ViewController.items.filter({ (item) -> Bool in
            return item.getName().lowercased().contains(searchText.lowercased())
        })
        isSearching = (searchText != "")
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredItems = []
    }
    
}


