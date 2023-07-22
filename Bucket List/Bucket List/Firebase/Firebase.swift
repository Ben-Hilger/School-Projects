//
//  Firebase.swift
//  Bucket List
//
//  Created by Ben Hilger on 10/31/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import Firebase

import Foundation
import Firebase

class FirebaseManager {
    
    static let dataBase : DatabaseReference = Database.database().reference(fromURL: "https://bucket-list-53347.firebaseio.com/")
    
    static func writeToDataBase(dir : String?, values : [String : Any]){
        var dB : DatabaseReference = dataBase
        if let directory = dir{
            dB = dB.child(directory);
        }
        
        dB.updateChildValues(values);
    }
    
    static func readFromDatabase(dir : String?, completion : @escaping ([String : AnyObject]?) -> ()){
        var dB : DatabaseReference = dataBase
        
        if let directory = dir {
            dB = dB.child(directory)
        }
        
        dB.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, s) in
            completion(snapshot.value as? [String : AnyObject] ?? [:])
        })
    }
}
