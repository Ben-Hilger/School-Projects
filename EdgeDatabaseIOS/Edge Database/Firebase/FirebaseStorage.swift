//
//  FirebaseStorage.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 11/2/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit
import AVFoundation
import SharedCode

class FirebaseStorageManager {
    
    private static let fireStorageManager : FirebaseStorageManager = FirebaseStorageManager()
    
    static func getFirebaseStorageManager() -> FirebaseStorageManager {
        return fireStorageManager
    }
    
    private let storage = Storage.storage().reference()
    
    func uploadProfileImage(image : UIImage, completion: @escaping (Bool, String?) -> Void) {
        
        let uid = UserManager.getUserManager().getUser().uid // Gets the uid of the user
        
        // Ensures the uid is valid
        if uid != "Unknown" {
            
            if let uploadData = image.pngData() {
                let imageLoc = storage.child("\(uid)/images/profile_image.png")
                imageLoc.putData(uploadData, metadata: nil) {
                    (metadata, error) in
                    guard metadata != nil else {
                        completion(false, "Error with metadata")
                        return
                    }
                    
                    completion(true, nil)
                }
            }
        }
    }
    
    func getProfileImage(completion: @escaping (UIImage?, String?) -> Void) {
        
        let uid = UserManager.getUserManager().getUser().uid
        
        if uid != "Unknown" {
            
            let imageLoc = storage.child("\(uid)/\(IMAGE_FILE_DIR)/\(PROFILE_IMAGE_ID)")
            
            imageLoc.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    completion(nil, error.localizedDescription)
                } else {
                    let image = UIImage(data: data!)
                    completion(image, nil)
                }
            }
            
        }
        
    }
    
    func uploadVideo(forTeamCode teamCode : String, forDrill d : Drill, forDrillNumber n : Int, withURL url: URL, completion: @escaping (Bool) -> Void) {
        // File located on disk
        let localFile = url
        print(localFile.absoluteString)
        // Create a reference to the file you want to upload
        let riversRef = storage.child("\(teamCode)/Drill_\(n)/\(VIDEO_FILE_DIR)/drill_video.mov")
        do {
            _ = try riversRef.putData(Data(contentsOf: localFile), metadata: nil) { metadata, error in
                guard metadata != nil else {
              // Uh-oh, an error occurred!
              return
            }
            // Metadata contains file metadata such as size, content-type.
            // You can also access to download URL after upload
            riversRef.downloadURL { (url, error) in
              guard let downloadURL = url else {
                // Uh-oh, an error occurred!
                return
              }
              // Stores the video URL within the drill information
                d.videoURL = downloadURL.absoluteString
              completion(true)
            }
            }
        } catch {
            completion(false)
        }
    }
    
    func uploadVideo(forTeam teamCode : String, forHomework hw : Homework, withName name : String, withURL url : URL, completion : @escaping (Bool) -> Void) {
        // Stores the video url
        let localFile = url
        // Stores the Firebase keys in the shared library
        let keys = FirebaseKeys()
        // Gets the reference to shore the video file
        let ref = storage.child("\(teamCode)/\(keys.homeworkKey)/Homework_\(hw.homework_id!)/\(VIDEO_FILE_DIR)/\(name)/homework_video.mov")
        // Attempts to upload the video to Firebase 
        do {
            _ = try ref.putData(Data(contentsOf: localFile), metadata: nil) { metadata, error in
                guard metadata != nil else {
                  // Uh-oh, an error occurred!
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                // You can also access to download URL after upload
                ref.downloadURL { (url, error) in
                    guard url != nil else {
                        // Uh-oh, an error occurred!
                        return
                    }
              
                    hw.videos[name] = url?.absoluteString
                    completion(true)
                }
            }
        } catch {
            completion(false)
        }
        
    }
    
    func deleteVideo(forTeam teamCode : String, forHomework hw : Homework, withName name : String, withURL url : URL, completion : @escaping (Bool) -> Void) {
        
        //let uid = hw.playerAssigned!
        //let instrucID = hw.instructorAssigned!
        let keys = FirebaseKeys()
        let ref = storage.child("\(teamCode)/\(keys.homeworkKey)/Homework_\(hw.homework_id!)/\(VIDEO_FILE_DIR)/\(name)/homework_video.mov")
        
        ref.delete { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                hw.videos.removeObject(forKey: name)
                completion(true)
            }
        }
        
    }

    private let IMAGE_FILE_DIR = "images"
    private let VIDEO_FILE_DIR = "videos"
    
    private let PROFILE_IMAGE_ID = "profileImage.png"
    
}
