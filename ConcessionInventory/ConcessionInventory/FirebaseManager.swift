//
//  Firebase.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/20/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager {
    
    private static let ITEM_COLLECTION = "INVENTORY"
    
    private static let LOOSE_ITEMS_ID = "LOOSE_ITEMS"
    private static let CASE_ARRAY_ID = "CASES"
    
    private static let CASE_AMT_PER_ID = "CASE_AMT_PER"
    private static let CASE_AMT = "CASE_AMT"
    private static let CASE_NAME = "CASE_NAME"
    
    static let dataBase : Firestore = Firestore.firestore()
    
    static func write(collection : String, docName: String, data : [String : Any]){
        let db : DocumentReference = dataBase.collection(collection).document(docName)
        db.setData(data)
    }
    
    static func read(collection : String, document : String, completion : (DocumentReference) -> Void) {
        let db = dataBase.collection(collection).document(document)
        completion(db)
    }
    
    static func saveInventoryDate(date : InventoryDate) {
        let name = date.getDateasString()
        let items = getSavedItemArrays(date: date)
        
        write(collection: ITEM_COLLECTION, docName: name, data: items)
        
    }
    
    static func loadInventoryDates(completion : @escaping ([InventoryDate]) -> Void) {
        var dates : [InventoryDate] = []
        dataBase.collection(ITEM_COLLECTION).getDocuments { (snap, err) in
            if let error = err {
                print(error.localizedDescription)
            }else{
                if let doc = snap?.documents {
                    for index in 0..<doc.count {
                        let name = doc[index].documentID
                        let inventoryDate : InventoryDate = InventoryDate(d: name)
                        loadItems(dateName: name, completion: { (items) in
                            inventoryDate.item = items
                            dates.append(inventoryDate)
                            if(index == doc.count-1){
                                completion(dates)
                            }
                        })
                    }
                }
            }
        }
    }
    
    static func getSavedItemArrays(date : InventoryDate) -> [String : [String : Any]]{
        var arr : [String : [String : Any]] = [:]
        var cases : [String : Any] = [:]
        
        for index in 0..<date.item.count{
            let item = date.item[index]
            for index in 0..<item.getCases().count {
                cases.updateValue(
                    [CASE_AMT_PER_ID : item.getCases()[index].getAmountPerCase(),
                     CASE_AMT : item.getCases()[index].getAmountOfCases(),
                     CASE_NAME : item.getCases()[index].getName()], forKey: item.getCases()[index].getName())
            }
            
            let data : [String : Any] = [
                LOOSE_ITEMS_ID : item.getLooseItems(),
                CASE_ARRAY_ID : cases
            ]
            arr.updateValue(data, forKey: item.getName())
        }
        return arr
    }
    
    static func getItemNames(name : String, completion : @escaping ([String]) -> Void) {
        var names : [String] = []
        
        dataBase.collection(ITEM_COLLECTION).document(name).getDocument(completion:  { (snap, error) in
            if let err = error {
                print(err.localizedDescription)
            }else{
                if let data = snap?.data() {
                    let names = data
                    completion(names.keys.sorted())
                }
                completion([])
            }
        })
    }
    
    static func loadItems(dateName : String, completion : @escaping ([Item]) -> Void) {
        var items : [Item] = []
        getItemNames(name: dateName,completion: { (names) in
            
            for index in 0..<names.count {
                let curName = names[index]
                read(collection: ITEM_COLLECTION, document: dateName, completion: { (document) in
                    document.getDocument(completion: { (snap, err) in
                        if let error = err {
                            print(error.localizedDescription)
                        }else{
                            if var data = snap?.data() {
                                data = data[curName] as! [String : Any]
                                let looseItem = data[LOOSE_ITEMS_ID] as! Int
                                
                               
                                let newItem = Item(name: curName)
                                newItem.updateLooseItems(li: looseItem)
                                
                                if let cases : [String : Any] = data[CASE_ARRAY_ID] as? [String : Any] {
                                    let sorted : [String] = cases.keys.sorted()
                                    print(cases)
                                    for index2 in 0..<sorted.count {
                                        let curCase : [String : Any] = cases[sorted[index2]] as! [String : Any]
                                        
                                        let name = sorted[index2]
                                        let amtPerCase = curCase[CASE_AMT_PER_ID] as! Int
                                        let amt = curCase[CASE_AMT] as! Int
                                        
                                        let newCase = CaseCounter(n: name, amt: amtPerCase)
                                        newCase.setAmount(a: amt)
                                        newItem.addCase(c: newCase)
                                    }
                                }
                                
                            
                                items.append(newItem)
                            }
                            if(index == names.count-1){
                                completion(items)
                            }
                        }
                    })
                })
                
            }
            
        })
        
    }
    
}
