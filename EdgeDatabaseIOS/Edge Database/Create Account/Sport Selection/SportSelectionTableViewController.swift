//
//  SportSelectionTableViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/25/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class SportSelectionTableViewController : UITableViewController {
    
    var delegate : SportSelectionDelegate?
    
    var sports : [String] = ["Softball", "Baseball", "Football", "Tennis"]
    
    var selectedSports : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(selectedSports)
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell : SportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Sport") as! SportTableViewCell
        
        cell.configureCell(sport: sports[indexPath.row])
        
        if selectedSports.contains(sports[indexPath.row]) {
            cell.sportLabel.textColor = UIColor.red
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sportSel = sports[indexPath.row]
        
        if selectedSports.contains(sportSel) {
            selectedSports.remove(at: selectedSports.firstIndex(of: sportSel)!)
            (tableView.cellForRow(at: indexPath) as! SportTableViewCell).sportLabel.textColor = UIColor.black
        } else {
            selectedSports.append(sportSel)
           (tableView.cellForRow(at: indexPath) as! SportTableViewCell).sportLabel.textColor = UIColor.red
        }
        
        
    }
    
    @IBAction func submit(sender : Any) {
        delegate?.sportSelected(sport: selectedSports)
    }

    
    @IBAction func back() {
        delegate?.cancel()
    }
    
}
