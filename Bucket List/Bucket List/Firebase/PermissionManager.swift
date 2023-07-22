//
//  PermissionManager.swift
//  Bucket List
//
//  Created by Ben Hilger on 11/12/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import Firebase

class PermissionManager {
    
    var uuid : String?
    var email : String?
    var accountInfo : [String: String]?
    
    var USER_SAVE_LOCATION : String?
    let USER_DISPLAY_NAME_ID : String = "display_name"
    
    var BUCKET_LIST_SAVE_LOCATION : String?
    
    let BUCKET_LIST_GENERAL_SAVE_ID : String = "info"
    let BUCKET_LIST_DATE_CREATED_ID : String = "dateCreated"
    
    let BUCKET_LIST_ITEM_DESCRPTION_ID : String = "description"
    let BUCKET_LIST_ITEM_POTENTIAL_DATES_ID : String = "potential_dates"
    let BUCKET_LIST_ITEM_DATE_ADDED_ID : String = "date_added"
    let BUCKET_LIST_ITEM_LOCATION_ID : String = "location"
    
    var CATEGORY_SAVE_LOCATION : String?
    var CATEGORY_ITEM_SAVE_LOCATION : String?

    
    func loginUser(username: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: username, password: password) { (user, err) in
            if let error = err {
                print(error.localizedDescription)
                completion(false)
            }else if let us = user{
                self.uuid = us.user.uid
                self.email = username
                self.setupSaveLocations()
                self.getBasicAccountInfo(completion: { (values) in
                    self.accountInfo = values
                    completion(true)
                })
            }
        }
    }
    
    func createUser(username : String, password : String){
        Auth.auth().createUser(withEmail: username, password: password) { (user, err) in
            if  let error = err {
                print(error.localizedDescription)
            }else if let us = user {
                self.email = username
                self.uuid =  us.user.uid
                self.setupSaveLocations()
            }
        }
    }
    
    func getBasicAccountInfo(completion: @escaping ([String : String]) -> Void) {
        FirebaseManager.readFromDatabase(dir: USER_SAVE_LOCATION) { (values) in
            if let info : [String : String] = values as? [String : String] {
                completion(info)
            }else{
                completion([:])
            }
        }
    }
    
    func saveBucketList(bucketList : Docket){
        let SAVE_LOCATION = BUCKET_LIST_SAVE_LOCATION! + "/" + bucketList.getNameOfList()
        
        let bucketListSaveItems : [String : String] =
            [BUCKET_LIST_DATE_CREATED_ID : bucketList.getReadableDate()]
        FirebaseManager.writeToDataBase(dir: SAVE_LOCATION + "/" + BUCKET_LIST_GENERAL_SAVE_ID, values: bucketListSaveItems)
        
        for index in 0..<bucketList.generalItems.count {
            saveBucketListItem(bucketListSaveLoc: SAVE_LOCATION, bucketListItem: bucketList.generalItems[index])
        }
        
    }
    
    private func generateBucketListItemSave(bucketListItem : DocketTaskFramework) -> [String : Any]{
        
        var bucketListItemSave : [String : Any] =
            [BUCKET_LIST_ITEM_DESCRPTION_ID : bucketListItem.getDescription(),
             BUCKET_LIST_ITEM_DATE_ADDED_ID : bucketListItem.getReadableDateAdded()]
        
        if(bucketListItem.hasPotentialDates()){
            bucketListItemSave.updateValue(bucketListItem.getReadablePotentialDates(), forKey: BUCKET_LIST_ITEM_POTENTIAL_DATES_ID)
        }
        
        if(bucketListItem.hasLocation()){
            bucketListItemSave.updateValue(bucketListItem.getLocation(), forKey: BUCKET_LIST_ITEM_LOCATION_ID)
        }
        
        return bucketListItemSave
    }
    
    func updateBasicAccountInfo(infoToUpdate : [String : String]) {
        FirebaseManager.writeToDataBase(dir: USER_SAVE_LOCATION, values: infoToUpdate)
    }
    
    func saveDockets(dockets : [Docket]) {
        for docket in dockets {
            let DOCKET_SAVE_LOCATION = docket.getDocketID()
            
            for cat in docket.categories.keys.sorted() {
                for task in docket.categories[cat]! {
                    
                }
                
                
            }
        }
    }
    
    
    func loadDockets(completion : @escaping ([Docket]) -> Void) {
        
        
        
        
    }
    
    func setupSaveLocations() {
        if let uid = uuid {
            USER_SAVE_LOCATION = uid + "/info"
            BUCKET_LIST_SAVE_LOCATION = uid + "/tasks-lists"
            CATEGORY_SAVE_LOCATION = "/categories"
            CATEGORY_ITEM_SAVE_LOCATION = "/items"
        }
    }
}

