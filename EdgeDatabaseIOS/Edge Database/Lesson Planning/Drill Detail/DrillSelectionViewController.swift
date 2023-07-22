//
//  CategorySelectionViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/8/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit
import SharedCode

class DrillSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Stores the current drill being presented
    var currentDrill : Drill!
    // Stores the instances for the drill and sport manager
    var drillManager : DrillManager = DrillManager.getDrillManager()
    var sportManager : SportManager = SportManager.sportManager
    // Stores the drill selection delegate
    var delegate : DrillSelectionDelegate?
    // Stores the current source being viewed
    var source : DrillSelectionSource = .Category
    // Outlet that controls the tableview
    @IBOutlet var categoryTable : UITableView!
    // Outlet that controls the navigation title
    @IBOutlet var mainTitle : UINavigationItem!
    // Outlet that controls the add button
    @IBOutlet var addButton : UIButton!
    // Stores the available difficulties
    var difficulty : [String] = [
        "Beginner",
        "Intermediate",
        "Advanced"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the delegate and datasource to this class
        categoryTable.delegate = self
        categoryTable.dataSource = self
        // Checks if the source is difficuly
        if source == .Difficulty {
            // Hides the add button since it's not used when selecting difficulty
            addButton.isHidden = true
        }
        // Sets the tile of the navigation bar
        mainTitle.title = "Select \(source.toString())"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Checks which source is being used
        if source == .Category {
            // Returns the number of drill categories
            return drillManager.getDrillCategories().count
        } else if source == .Sport {
            // Returns the number of sports
            return sportManager.currentSports.count
        } else if source == .Position{
            // Returns the number of the positions in the selected sport
            return currentDrill.sport.positions.count
        } else {
            // Returns the number of difficulties
            return difficulty.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Gets the appropriate cell from the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category") as! CategoryTableViewCell
        // Checks which source is being used
        if source == .Category {
            // Stores the drill categories
            let category = drillManager.getDrillCategories()[indexPath.row]
            // Configures the cell with the category name
            cell.setupCell(forString: category.categoryName)
            // Checks if the drill contains the category
            for cat in currentDrill.category as? [DrillCategory] ?? [] {
                if cat.categoryName == category.categoryName {
                    // Adds a checkmark to the cell to indicate that the drill is in this category
                    cell.accessoryType = .checkmark
                } else {
                    // Removes any trace of a checkmark
                    cell.accessoryType = .none
                }
            }
        } else if source == .Sport {
            // Configures the cell with the name of the current sport
            cell.setupCell(forString: sportManager.currentSports[indexPath.row].name)
        } else if source == .Position{
            // Configures the cell with the name of the positions of the sport the drill is in
            cell.setupCell(forString: (currentDrill.sport.positions as! [DrillPosition])[indexPath.row].name)
        } else {
            // Configures the cell with the respective difficulty
            cell.setupCell(forString: difficulty[indexPath.row])
        }
        // Returns the cell
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Checks which source is being viewed
        if source == .Category {
            // Gets the selected category
            let categorySelected = drillManager.getDrillCategories()[indexPath.row]
            var found = false
            let drillCategories = currentDrill.category as? [DrillCategory] ?? []
            // Checks to see if the current drill is within the selected category
            for index in 0..<drillCategories.count {
                if drillCategories[index].categoryName == categorySelected.categoryName {
                    found = true
                    // Removes the specified drill category
                    currentDrill.category.removeObject(at: index)
                    // Checks if there's no other categories after this one was removed
                    if currentDrill.category.count == 0 {
                        // Adds the unassigned category
                        currentDrill.category.add(DrillCategory(name: "Unassigned"))
                    }
                    // Breaks out of the for loop
                    break
                }
            }
            // Checks if the category wasn't found
            if !found {
                // Adds the category to the current drill
                currentDrill.category.add(categorySelected)
                // Explores the drill categories to ensure that unassigned gets removed
                for index in 0..<drillCategories.count {
                    if drillCategories[index].categoryName == "Unassigned" {
                        // Removes the unassigned category
                        currentDrill.category.removeObject(at: index)
                    }
                }
            }
            // Reloads the tableview data
            tableView.reloadData()
            // Calls the delegate to update the categories
            delegate?.updatedCategories()
            return
        } else if source == .Sport {
            // Gets the sports selected
            let sportSelected = sportManager.currentSports[indexPath.row]
            // Sets the current drill sport
            currentDrill.sport = sportSelected
            // Resets the current drill position
            currentDrill.position = DrillPosition(n: "Unassigned")
        } else if source == .Position {
            // Gets the position selected
            let positionSelected = currentDrill.sport.positions[indexPath.row]
            // Sets the current drills position
            currentDrill.position = positionSelected as! DrillPosition
        } else {
            // Gets the difficulty selected
            let diff : String = difficulty[indexPath.row]
            // Sets the difficulty of the current drill
            currentDrill.difficulty = diff
        }
        // Calls the delegate now that the selection is completed
        delegate?.selectionCompleted()
    
    }
    
    @IBAction func addCategory(sender : Any) {
        // Generates an alert to add a new option in the selected source
        let alert = AlertUtil.generateAlertViewController(withTitle: "Add \(source.toString())", withMessage: "Please enter the name of the new \(source.toString()) below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter \(source.toString()) Name..."])
        // Creates an add action
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            // Generates an activity alert to inform the user that the new option is being added
            let activityAlert = AlertUtil.generateActivityAlert(withMessage: "Adding \(self.source.toString())")
            // Presents the avtivity alert to the user
            self.present(activityAlert, animated: true) {
                // Checks if there's valid text in the textfield
                if let text = alert.textFields?[0].text {
                    // Checks that something was entered
                    if !text.elementsEqual("") {
                        // Checks which source was being used
                        if self.source == .Category {
                            // Attempts to add the new category
                            _ = self.drillManager.getDrillCategory(withName: text)
                        } else if self.source == .Position {
                            // Attmepts to add the new position
                            _ = self.sportManager.getPosition(withName: text, withSportName: self.currentDrill.sport.name)
                        } else {
                            // Attempts to add the new sport
                            _ = self.sportManager.getSport(withName: text)
                        }
                        // Changes the activity alert message to inform the user it was added
                        activityAlert.message = "\(self.source.toString()) Added"
                        // Dismisses the activty alert
                        self.dismiss(animated: true, completion: nil)
                        // Reloads the tableview data
                        self.categoryTable.reloadData()
                    } else {
                        // Generates an alert to inform the user they entered nothing into the textfield
                        let emptyAlert = AlertUtil.generateAlertViewController(withTitle: "Add \(self.source.toString())", withMessage: "Please enter valid input", withStyle: .alert, actions: [AlertUtil.doneAction])
                        // Dismissess the activity alert
                        self.dismiss(animated: true) {
                            // Presents the empty alert
                            self.present(emptyAlert, animated: true, completion: nil)
                        }
                    }
                } else {
                    // Generates an error alert to inform the user that there was an issue adding the new option
                    let errorAlert = AlertUtil.generateAlertViewController(withTitle: "Add \(self.source.toString())", withMessage: "Sorry but there was an error when adding this \(self.source.toString().lowercased()), please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                    // Dismissess the activty alert
                    self.dismiss(animated: true) {
                        // Presents the error alert
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }
        }
        // Adds the add activity to the alert
        alert.addAction(add)
        // Presents the alert to the user
        self.present(alert, animated: true, completion: nil)
    }
}

protocol DrillSelectionDelegate {
    func selectionCompleted()
    func updatedCategories()
}

enum DrillSelectionSource {
    case Category
    case Sport
    case Position
    case Difficulty
    
    func toString() -> String {
        switch self {
        case .Category:
            return "Category"
        case .Sport:
            return "Sport"
        case .Position:
            return "Position"
        case .Difficulty:
            return "Difficulty"
        }
    }
    
}
