//
//  FirebaseCore.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/12/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCore {
    
    // Stores the instance of the logger for this class
    private let coreLogger = Logger(tag: "FirebaseCore")
    
    func updateWithTransaction(collection : String, document : String, information : [String : Any], completion : @escaping (Bool) -> ()) {
        // Logs the event to the console
        coreLogger.writeInfo(msg: "Updating information at collection: \(collection) and document: \(document)")
        // Stores an instance of the Firebase database
        let database = Firestore.firestore()
        // Stores the reference to the document on Firebase
        let reference = database.collection(collection).document(document)
        // Attempts to update the information on Firebase with the specified document
        database.runTransaction({ (transaction, error) -> Any? in
            transaction.updateData(information, forDocument: reference)
        }) { (object, error) in
            if let error = error {
                self.coreLogger.writeError(msg: error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func setDataForce(collection : String, document : String, information : [String : Any], completion : @escaping (Bool) -> ()) {
        coreLogger.writeInfo(msg: "Forcefully setting data at collection: \(collection) and document \(document)\nWarning this is only recommended with setting initial account info")
        let database = Firestore.firestore()
        let reference = database.collection(collection).document(document)
        reference.setData(information, merge: true) { (error) in
            if let error = error {
                self.coreLogger.writeError(msg: error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func readInformation(collection : String, document : String, completion : @escaping ([String : Any]?) -> ()) {
        // Logs the event to the console
        coreLogger.writeInfo(msg: "Reading information at collection: \(collection) and document: \(document)")
        // Stores an instance of the Firebase database
        let database = Firestore.firestore()
        // Stores the reference to the document on Firebase
        let reference = database.collection(collection).document(document)
        // Attemps to read the data at the specified firebase document
        reference.getDocument { (documentsnap, error) in
            // Checks if there was an error reading the information
            if let error = error {
                // Reports the error to the consol
                self.coreLogger.writeError(msg: error.localizedDescription)
                // Returns an empty dictionary
                completion(nil)
            } else {
                // Returns the data from the document, or nil if it doesn't exist
                completion(documentsnap?.data())
            }
        }
    }
    
    // Stores an instance of the firebase core
    static let instance = FirebaseCore()
    
}
