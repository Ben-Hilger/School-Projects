//
//  HomeworkVideoViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/29/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import Photos
import SharedCode

class HomeworkVideoViewController : UITableViewController {
    
    var team : Team?
    var homeworkToView : Homework?
    
    var workingName : String?
    
    
    var pickerController : UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkToView?.videos.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! CenterDetailTableViewCell
        
        if let homework = homeworkToView {
            cell.configureCell(withDetail: (homeworkToView?.videos as! [String : String]).keys.sorted()[indexPath.row])
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let options = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Please select an option below", withStyle: .actionSheet, actions: [AlertUtil.cancelAction])
        
        let viewVideo = UIAlertAction(title: "View Video", style: .default) { (action) in
            let player = AVPlayerViewController()
            
            if let homework = self.homeworkToView {
                player.player = AVPlayer(url: URL(fileURLWithPath: homework.videos[(self.homeworkToView?.videos as! [String : String]).keys.sorted()[indexPath.section]]! as! String))
            }
                           
            self.present(player, animated: true) {
               player.player?.play()
            }
        }
        
        let deleteVideo = UIAlertAction(title: "Remove Video", style: .default) { (action) in
            if let homework = self.homeworkToView {
                let videoName = (self.homeworkToView?.videos as! [String : String]).keys.sorted()[indexPath.row]
                let videoURL = homework.videos[videoName]
                
                FirebaseStorageManager.getFirebaseStorageManager().deleteVideo(forTeam: self.team!.teamCode, forHomework: homework, withName: videoName, withURL: URL(fileReferenceLiteralResourceName: videoURL! as! String)) { (success) in
                    if !success {
                        let unable = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "We're sorry but there was an error removing this video, please try again later.", withStyle: .alert, actions: [AlertUtil.doneAction])
                        self.present(unable, animated: true, completion: nil)
                    } else {
                       let success = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "The video was successfully removed.", withStyle: .alert, actions: [AlertUtil.doneAction])
                        self.present(success, animated: true, completion: nil)
                    }
                }
            }
        }
        
        options.addAction(viewVideo)
        options.addAction(deleteVideo)
     
        self.present(options, animated: true, completion: nil)
    }
    
    func displayVideoSelection() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
           if response {
               DispatchQueue.main.async {
                   PHPhotoLibrary.requestAuthorization { (rresponse) in
                       if rresponse == .authorized {
                           DispatchQueue.main.async {
                               self.pickerController.delegate = self
                               self.pickerController.allowsEditing = true
                               self.pickerController.mediaTypes = ["public.movie"]
                               self.pickerController.videoQuality = .typeHigh
                               
                               let alert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: nil, withStyle: .actionSheet, actions: [AlertUtil.cancelAction])
                               
                               if let action = self.generateVideoAlertAction(forType: .camera, title: "Take video") {
                                   alert.addAction(action)
                               }
                               
                               if let action = self.generateVideoAlertAction(forType: .savedPhotosAlbum, title: "Camera roll") {
                                   alert.addAction(action)
                               }
                               
                               if let action = self.generateVideoAlertAction(forType: .photoLibrary, title: "Video Library") {
                                   alert.addAction(action)
                               }
                               
                               self.present(alert, animated: true, completion: nil)
                           }
                       }
                   }
               }
           } else {

           }
        }
               
    }
    
    func generateVideoAlertAction(forType t : UIImagePickerController.SourceType, title : String) -> UIAlertAction? {
        
        guard UIImagePickerController.isSourceTypeAvailable(t) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = t
            self.present(self.pickerController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addVideo(sender : Any) {
        
        let name = AlertUtil.generateAlertViewController(withTitle: "Create Video", withMessage: "Please enter a name for the video below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Name Here..."])
        
        let create = UIAlertAction(title: "Done", style: .default) { (action) in
            if let text = name.textFields?[0].text, !text.elementsEqual("") {
                print("HERERE")
                if let homework = self.homeworkToView {
                    if !(self.homeworkToView?.videos as! [String : String]).keys.contains(text) {
                        self.workingName = text
                        self.displayVideoSelection()
                    } else {
                        let nameConflict = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "A video with that name already exists", withStyle: .alert, actions: [AlertUtil.doneAction])
                        self.present(nameConflict, animated: true, completion: nil)
                    }
                }
            }
        }
        
        name.addAction(create)
        
        self.present(name, animated: true, completion: nil)
    }
    
    @IBAction func done(sender : Any) {
        if let homework = homeworkToView {
            HomeworkManager.getHomeworkManager().saveHomework(homeworkToSave: homework) { _ in
                self.performSegue(withIdentifier: "backToHomeworkList", sender: nil)
            }
        } else {
            self.performSegue(withIdentifier: "backToHomeworkList", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.elementsEqual("toHomework") ?? false {
            let des = segue.destination as! LessonScheduleViewController
        }
    }
    
}

// MARK: - UIImagePickerControllerDelegate
 extension HomeworkVideoViewController: UIImagePickerControllerDelegate {
    
    func pickerController(_ controller: UIImagePickerController, didSelect url: URL?) {
        
        if let url = url {
            
            let uploadActivity = AlertUtil.generateActivityAlert(withMessage: "Uploading Video....")
            self.dismiss(animated: true) {
                self.present(uploadActivity, animated: true) {
                    FirebaseStorageManager.getFirebaseStorageManager().uploadVideo(forTeam: self.team?.teamCode ?? "", forHomework: self.homeworkToView!, withName: self.workingName!, withURL: url) { (value) in
                        if !value {
                           let errorAlert = AlertUtil.generateAlertViewController(withTitle: "Uploading", withMessage: "There was a problem uploading your video, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                           
                           self.dismiss(animated: true) {
                               self.present(errorAlert, animated: true, completion: nil)
                           }
                        } else {
                            uploadActivity.message = "Video Uploaded!"
                            self.tableView.reloadData()
                            self.dismiss(animated: true, completion: nil)
                        }
                                   
                          
                    }
                }
            }
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
     
    }
   
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let url = info[.mediaURL] as? URL else {
            return self.pickerController(picker, didSelect: nil)
        }
        
        self.pickerController(picker, didSelect: url)
    }
    
}

// MARK: - UINavigationControllerDelegate
extension HomeworkVideoViewController: UINavigationControllerDelegate {
}
