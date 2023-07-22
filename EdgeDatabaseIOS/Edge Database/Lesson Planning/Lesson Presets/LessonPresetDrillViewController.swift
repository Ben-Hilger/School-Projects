//
//  LessonPresetDrillViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/29/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit
import SharedCode

class LessonPlanDrillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // The tableview that manages the viewing of the drills
    @IBOutlet var tableView : UITableView!
    // Drill Manager that manages all of the drills
    var drills : DrillManager = DrillManager.getDrillManager()
     // The delegate that deals with the lesson presete
    var delegate : LessonDrillDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the tableview delegate and datasource to this class
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of drills
        return drills.getDrills().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieves the cell from the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrillDetail") as! LeftDetailTableViewCell
        // Configures the cell with the drill name
        cell.configureCell(withString: drills.getDrills()[indexPath.row].name)
        // Checks if the drill is within the lesson preset
        if delegate?.isWithinLessonPreset(drill: drills.getDrills()[indexPath.row]) ?? false {
            // Adds a checkmark to the cell to indicate it's within the lesson plan
            cell.accessoryType = .checkmark
        } else {
            // Ensures there's no checkmark
            cell.accessoryType = .none
        }
        // Returns the configured cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Retrieves and stores the drill selected by the user
        let drillSelected : Drill = drills.getDrills()[indexPath.row]
        // Calls the delegate function to edit the lesson preset as necessary
        delegate?.drillSelected(drill: drillSelected, completion: { (selected) in
            // Checks if the selected drill is in the lesson preset
            if selected {
                // Gets the cell at the index the user pressed
                let cell = tableView.cellForRow(at: indexPath) as! LeftDetailTableViewCell
                // Reconfigures the cell to indicate it's been selected
                cell.accessoryType = .checkmark
            } else {
                // Gets the cell at the index
                let cell = tableView.cellForRow(at: indexPath) as! LeftDetailTableViewCell
                // Reconfigures the cell to indicate it's no longer been selected
                cell.accessoryType = .none
            }
        })

    }
    
    @IBAction func done(sender : Any) {
        // Calls the delegate to inform that this view is no longer necessarys
        delegate?.done()
    }

}

// MARK: - LessonDrillDelegate Methods

protocol LessonDrillDelegate {
    func drillSelected(drill : Drill, completion : (_ selected : Bool) -> ())
    func done()
    func isWithinLessonPreset(drill : Drill) -> Bool
}
