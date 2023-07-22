//
//  ViewController.swift
//  Daily Planner
//
//  Created by Benjamin Hilger on 10/27/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView : UITableView!
    
    var items : [ListItem] = [  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableView.delegate = self
        tableView.dataSource = self
        
        items = [
            ListItem(d: "Workout", onClick: {
                print("AGAGAERGGA")
                self.present(self.storyboard?.instantiateViewController(identifier: "workOut") as! WorkOutViewController
, animated: true, completion: nil)
            
            })
        ]
        
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listItem") as! ListTableViewCell
        
        cell.configureCell(number: indexPath.row+1, item: items[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].clicked()
    }

}

