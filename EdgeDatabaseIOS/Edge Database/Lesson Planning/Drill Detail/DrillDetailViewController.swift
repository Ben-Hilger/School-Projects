//
//  DrillDetailViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/7/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import Photos
import SharedCode

class DrillDetailViewController : UITableViewController, UIPopoverPresentationControllerDelegate {
    // Stores the current drill being viewed
    var drillToView : Drill!
    // Used only to revert changes if firebase is unavilable
    var origDrill : Drill!
    // Stores the pickercontroller used for picking the drill video
    var pickerController : UIImagePickerController = UIImagePickerController()
    // Outlet that displays the drills name
    @IBOutlet var drillName : UINavigationItem!
    // Outlet that controls the done button
    @IBOutlet var doneButton : UIButton!
    // Stores if the user has permission to change the drill information
    var canChange = true
    // Stores the main labels of the drill
    var mainLabels : [String] = [
        "Name",
        "Difficulty",
        "Category",
        "Sport",
        "Position",
        "Video"
    ]
    // Stores the labels of the cells
    var categoryLabels : [String] = []
    // Stores the index of the drill video
    var videoIndex : Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the origDrill to the drill currently being viewed
        origDrill = drillToView
        // Configures the cell labels
        configureCellLabels()
        // Configures/registers the TableViewCells
        configureCells()
        // Checks if the user can't save
        if !canChange {
            // Hides and disables the done button so the user can't make changes
            doneButton.setTitle("", for: .normal)
            doneButton.isHidden = true
            doneButton.isEnabled = false
        }
        
    }

    
    func configureCellLabels() {
        // Sets the labels according to drill information
        categoryLabels = [
            drillToView.name,
            drillToView.difficulty,
            drillToView.category.count > 1 ? "Multiple" : drillToView.category.count == 1 ? (drillToView.category[0] as! DrillCategory).categoryName : "None Selected",
            drillToView.sport.name,
            drillToView.position.name,
            drillToView.videoURL != nil ? "Click to View Video" : "No Video Selected"
        ]
        // Reloads the TableViewData
        tableView.reloadData()
    }
    
    func configureCells() {
        // Configures the drillDetail static cell
        let drillDetail = UINib(nibName: "DrillDetailStaticTableViewCell", bundle: Bundle.main)
        self.tableView.register(drillDetail, forCellReuseIdentifier: "DrillDetail")
        // Configures the drillVideo static cell
        let drillVideo = UINib(nibName: "DrillVideoStaticTableViewCell", bundle: Bundle.main)
        self.tableView.register(drillVideo, forCellReuseIdentifier: "DrillVideo")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Sets the title of the view
        drillName.title = "Drill Information"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks if the user is going to the showCategories view
        if segue.identifier?.elementsEqual("showCategories") ?? false {
            // Gets the destination view
            let des = segue.destination as! DrillSelectionViewController
            // Sets the delegate to the source (this class)
            des.delegate = segue.source as! DrillDetailViewController
            // Ses the source according to the sender information
            des.source = (sender as! [Any])[2] as! DrillSelectionSource
            // Configures the destination as a popover view
            des.modalPresentationStyle = .popover
            des.popoverPresentationController?.sourceView = (sender as! [Any])[1] as! DrillDetailStaticTableViewCell
            des.popoverPresentationController?.delegate = self
            // Sets the current drill according to the sender information
            des.currentDrill = (sender as! [Any])[0] as? Drill
        } else if segue.identifier?.elementsEqual("showVideo") ?? false { // Checks if the user is viewing the video
            // Gets the destination view
            let des = segue.destination as! AVPlayerViewController
            // Sets the player
            des.player = AVPlayer(url: sender as! URL)
        
        }
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Checks if the current cell isn't the video index
        if indexPath.section == 0 && indexPath.row != videoIndex {
            // Gets the drillDetail cell, or returns a generic cell if there is an issue
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrillDetail") as? DrillDetailStaticTableViewCell else {
                return UITableViewCell()
            }
            // Configures the cell with the appropriate information
            cell.setupCell(forMain: mainLabels[indexPath.row] , forCategory: categoryLabels[indexPath.row])
            // Returns the cell
            return cell
        } else {
            // Gets the drillVideo cell, or returns a generic cell if there's an issue
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrillVideo") as? DrillVideoStaticTableViewCell else {
                return UITableViewCell()
            }
            // Configures the cell for the video
            cell.setupCell(forDelegate: self, forDrill: drillToView)
            // Returns the cell
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Checks if the user can make changes
        if !canChange {
            // Returns if the user doesn't
            return
        }
        // Checks if the selected cell is a category, position or sport cell
        if indexPath.section == 0 && (indexPath.row != videoIndex && indexPath.row != 0) { // Category, Position or Sport Cells
            // Gets the source based on the user's selection
            let source : DrillSelectionSource = indexPath.row == 1 ? .Difficulty : indexPath.row == 2 ? .Category : indexPath.row == 3 ? .Sport : .Position
            // Takes the user to the showCategories
            self.performSegue(withIdentifier: "showCategories", sender: [
                drillToView!,
                tableView.cellForRow(at: indexPath)!,
                source
            ])
        } else if indexPath.section == 0 && indexPath.row == 0 {
            // Checks if the user selected the drill name
            // Generates an alert to change the drill name
            let nameChangeAlert = AlertUtil.generateAlertViewController(withTitle: "Change Drill Name", withMessage: "Please enter the new drill name below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: [self.drillToView.name])
            // Creates an alert action for when the user enters the new drill name
            let doneAlert = UIAlertAction(title: "Done", style: .default) { (action) in
                // Checks if the text field is valid
                if let text = nameChangeAlert.textFields?[0].text {
                    // Checks if something was entered
                    if !text.elementsEqual("") {
                        // Checks if there is a valid drill number
                        if let num = self.drillToView.drill_number {
                            // Checks if there's a valid team being used
                            if let team = TeamManager.instance.teamEditing {
                                // Attempts to save the drill
                                FirebaseDrills.instance.saveDrill(drillToSave: self.drillToView, drill_number: Int(truncating: num), forTeam: team.teamCode) { (success) in
                                    // Puts this back on the main thread
                                    DispatchQueue.main.async {
                                        // Checks if it was success
                                        if success {
                                            // Sets the name of the drill to the text entered
                                            self.drillToView.name = text
                                            // Configures the cell labels
                                            self.configureCellLabels()
                                            // Reloads the tableview
                                            self.tableView.reloadData()
                                        } else {
                                            // Generates an alert to inform the user that there was an issue  saving the name
                                            let cantChangeAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "There was an issue saving your name, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                                            // Presents the cantChangeAlert
                                            self.present(cantChangeAlert, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // Adds the done alert to the nameChangeAlert
            nameChangeAlert.addAction(doneAlert)
            // Presents the nameChangeAlert to the user
            self.present(nameChangeAlert, animated: true, completion: nil)
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func returnToDrills(sender : Any) {
        // Checks if the necessary fields are met
        if canChange, let team = TeamManager.instance.teamEditing, let drillnumber = drillToView.drill_number {
            // Attempts to save the drill
            FirebaseDrills.instance.saveDrill(drillToSave: drillToView, drill_number: Int(truncating: drillnumber), forTeam: team.teamCode) { (success) in
                // Checks if it was successfull
                if success {
                    // Takes the user back to the drills
                    self.performSegue(withIdentifier: "backToDrills", sender: nil)
                } else {
                    // Generates an alert informing the user there was an issue saving the information
                    let failureAlert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "There was an issue saving your information, some changes may not be saved", withStyle: .alert)
                    // Creates a done action to take the user back to the drills
                    let done = UIAlertAction(title: "Done", style: .default) { (action) in
                        self.performSegue(withIdentifier: "backToDrills", sender: nil)
                    }
                    // Adds the done action to the faliure
                    failureAlert.addAction(done)
                    // Presents the failure alert
                    self.present(failureAlert, animated: true, completion: nil)
                }
            }
        } else {
            // Takes the back user to the drill view
            self.performSegue(withIdentifier: "backToDrills", sender: nil)
        }
    }
}


// MARK: - DrillSelectionDelegate
extension DrillDetailViewController : DrillSelectionDelegate {
   
    func updatedCategories() {
        // Configures the cell labels
        self.configureCellLabels()
        // Reloads the tableview data
        self.tableView.reloadData()
    }
    
    func selectionCompleted() {
        // Configures the cell labels
        configureCellLabels()
        // Reloads the tableview data
        tableView.reloadData()
        // Dismisses the popover drill view
        self.dismiss(animated: true, completion: nil)
    }
}

 // MARK: - UIImagePickerControllerDelegate
 extension DrillDetailViewController: UIImagePickerControllerDelegate {
    
    func pickerController(_ controller: UIImagePickerController, didSelect url: URL?) {
        // Checks to see if there is a valid url
        if let url = url {
            // Generates an activity alert to indicaite the uploading activity
            let uploadActivity = AlertUtil.generateActivityAlert(withMessage: "Uploading Video....")
            self.dismiss(animated: true) {
                // Presents the activity alert to the user
                self.present(uploadActivity, animated: true) {
                    if let team = TeamManager.instance.teamEditing {
                        // Attempts to upload the video to Firebase
                        FirebaseStorageManager.getFirebaseStorageManager().uploadVideo(forTeamCode: team.teamCode, forDrill: self.drillToView, forDrillNumber: self.drillToView.drill_number as! Int, withURL: url, completion: { success in
                            // Checks if it failed
                            if !success {
                                self.drillToView.videoURL = nil
                                // Generates the error alert to show to the user
                                let errorAlert = AlertUtil.generateAlertViewController(withTitle: "Uploading", withMessage: "There was a problem uploading your video, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                                // Dismisses the activity alert
                                self.dismiss(animated: true) {
                                    // Presents the error alert to the user
                                    self.present(errorAlert, animated: true, completion: nil)
                                }
                            }
                            // Changes the activity alert to indicate the video was uploaded
                            uploadActivity.message = "Video Uploaded!"
                            // Reconfigures the table view cells
                            self.configureCellLabels()
                            // Reloads the table view
                            self.tableView.reloadData()
                            // Dismisses the activity alert
                            self.dismiss(animated: true, completion: nil)
                        })
                    }
                }
            }
            
        }
        
     
    }
   
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Checks to ensure a valid url was sent
        guard let url = info[.mediaURL] as? URL else {
            return self.pickerController(picker, didSelect: nil)
        }
        
        self.pickerController(picker, didSelect: url)
    }
    
 }


// MARK: - Drill Video Management
extension DrillDetailViewController : DrillVideoDelegate {
    
    func startVideoSelection() {
        // Checks to see if there's a video url
        if self.drillToView.videoURL == nil {
            // Checks to see if the user can select a video
            if canChange {
                // Displays the option to change the video
                displayVideoSelection()
            }
        } else {
            // Generates an alert to give the user the option to view the video
            let alert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: nil, withStyle: .actionSheet, actions: [AlertUtil.cancelAction])
            // Creates an alert action to view the account
            let viewVideo = UIAlertAction(title: "View Video", style: .default) { (action) in
                // Checks to see if there is a valid video url
                if let videoUrl = self.drillToView.videoURL {
                    // Creates a player view controller
                    let player = AVPlayerViewController()
                    // Creates a player with the specified url
                    player.player = AVPlayer(url: URL(fileURLWithPath: videoUrl))
                    // Presents the video to the user
                    self.present(player, animated: true) {
                        // Plays the video
                        player.player?.play()
                    }
                }
            }
            // Creates an alert action to change the video
            let changeVideo = UIAlertAction(title: "Change Video", style: .default) { (action) in
                // Allows the user to pick a new video
                self.displayVideoSelection()
            }
            // Adds the action to view the video
            alert.addAction(viewVideo)
            // Checks to make sure the user has the permissions to change the video
            if canChange {
                // Adds the action to change the video
                alert.addAction(changeVideo)
            }
            // Presents the alert to the user
            self.present(alert, animated: true, completion: nil)
        }
        
       
        
    }
    
    func displayVideoSelection() {
        // Attempts to request access
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            // Checks if the user allowed accesss
            if response {
                // Ensures that this is run on the main thread
                DispatchQueue.main.async {
                    // Attempts to request access to the photo library
                    PHPhotoLibrary.requestAuthorization { (rresponse) in
                        // Checks if the user authorized the use of the photo library
                        if rresponse == .authorized {
                        
                            DispatchQueue.main.async {
                                // Configures the pickerController
                                self.pickerController.delegate = self
                                self.pickerController.allowsEditing = true
                                self.pickerController.mediaTypes = ["public.movie"]
                                self.pickerController.videoQuality = .typeHigh
                                // Generates an alert to allow the user to select/film a video
                                let alert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: nil, withStyle: .actionSheet, actions: [AlertUtil.cancelAction])
                                // Adds the action to take the video if available on the device
                                if let action = self.generateVideoAlertAction(forType: .camera, title: "Take video") {
                                    alert.addAction(action)
                                }
                                // Adds the action to choose from the camera roll if available on the device
                                if let action = self.generateVideoAlertAction(forType: .savedPhotosAlbum, title: "Camera roll") {
                                    alert.addAction(action)
                                }
                                // Adds the action to choose from the video library if availalbe on the device
                                if let action = self.generateVideoAlertAction(forType: .photoLibrary, title: "Video Library") {
                                    alert.addAction(action)
                                }
                                // Presents the video alert action to the user
                                self.present(alert, animated: true, completion: nil)
                           }
                       }
                   }
               }
            } else {
                // Presents an alert to inform the user that they need to give the app the necessary permissions
                self.present(AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "In order to select a video, you must give this app access to your camera and video library in your setting", withStyle: .alert, actions: [AlertUtil.cancelAction]), animated: true, completion: nil)
            }
        }
               
    }
    
    func generateVideoAlertAction(forType t : UIImagePickerController.SourceType, title : String) -> UIAlertAction? {
        // Checks if the desired source is available on the device
        guard UIImagePickerController.isSourceTypeAvailable(t) else {
            return nil
        }
        // Returns a new alert action
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = t
            self.present(self.pickerController, animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - UINavigationControllerDelegate
extension DrillDetailViewController: UINavigationControllerDelegate {
}
