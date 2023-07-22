//
//  Firestore.swift
//  Punch List
//
//  Created by Benjamin Hilger on 7/29/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import Firebase

class FirestoreManager {
    
    private var fireStore : Firestore = Firestore.firestore()
    
    func savePunchList() {
        let punchList : [PunchItem] = PunchListManager.getPunchListManager().getPunchList()
        
        for item in punchList {
            savePunchItem(item: item)
        }
    }
    
    func savePunchItem(item : PunchItem) {
        
        if let docName = item.fireStoreDIR {
            let itemRef = fireStore.collection("items").document(docName)
            
            fireStore.runTransaction({ (transaction, errorPointer) -> Any? in
                let sfDocument: DocumentSnapshot
                do {
                    try sfDocument = transaction.getDocument(itemRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                
                // Note: this could be done without a transaction
                //       by updating the population using FieldValue.increment()
                transaction.updateData([self.ITEM_DESP_SAVE : item.getItem(), self.ITEM_DESP_SAVE : item.getDueDate(), self.ITEM_CATEGORY_NAME_SAVE : item.getCategory().getName()], forDocument: itemRef)
                return nil
            }) { (object, error) in
                if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("Transaction successfully committed!")
                }
            }
        } else {
            fireStore.collection("items").addDocument(data: [ITEM_DESP_SAVE : item.getItem(), ITEM_DUE_DATE_SAVE : item.getDueDate(), ITEM_CATEGORY_NAME_SAVE : item.getCategory().getName()])
        }
    }
    
    func loadPunchList(completion : @escaping ([PunchItem]) -> Void) {
        
        fireStore.collection("items").getDocuments { (documents, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            var items : [PunchItem] = []
            
            for document in documents!.documents {
                let info = document.data()
                
                let desp = info[self.ITEM_DESP_SAVE] as? String ?? "No Desp"
                let dueDate = info[self.ITEM_DUE_DATE_SAVE] as? Date ?? Date()
                let catName = info[self.ITEM_CATEGORY_NAME_SAVE] as? String ?? "No Category"
                
                let item = PunchItem(i: desp, cat: Category(n: catName), dD: dueDate)
                
                item.fireStoreDIR = document.documentID
                
                items.append(item)
                
            }
            
            completion(items)
            
        }
    }
    
    private static var fireMan : FirestoreManager = FirestoreManager()
    
    static func getFirestoreManager() -> FirestoreManager {
        return fireMan
    }
    
    private let ITEM_DESP_SAVE : String = "ITEM_NAME"
    private let ITEM_DUE_DATE_SAVE : String = "ITEM_DUE_DATE"
    private let ITEM_CATEGORY_NAME_SAVE : String = "ITEM_CATEGORY_NAME"
    
}
