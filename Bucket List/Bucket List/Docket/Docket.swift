//
//  ToDoList.swift
//  Bucket List
//
//  Created by Ben Hilger on 11/14/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation

class Docket {
    
    var docketID : String!
    var nameOfList : String!
    var generalDescription : String!
    
    var dateCreated : Date!
    var targetDateOfCompletion : Date!
    
    var categories : [String : [DocketTaskFramework]] = [:]
    var generalItems : [DocketTaskFramework] = []
    
    let permManager : PermissionManager = AppDelegate.permManager
    
    init(docID : String, n : String, genDes : String, targetD : Date) {
        nameOfList = n
        generalDescription = genDes
        
        targetDateOfCompletion = targetD
        dateCreated = Date()
        
        docketID = docID
    }
    
    func getDocketID() -> String {
        return docketID
    }
    
    func getNameOfList() -> String {
        return nameOfList
    }
    
    func changeNameOfList(newName : String){
        nameOfList = newName
    }
    
    func getGeneralDescription() -> String {
        return generalDescription
    }
    
    func changeGeneralDescription(newDes : String){
        generalDescription = newDes
    }
    
    func getDate() -> Date {
        return dateCreated
    }
    
    func getReadableDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: dateCreated)
    }
    
    func getCategories() -> [String : [DocketTaskFramework]] {
        return categories
    }
    
    func getGeneralItems() -> [DocketTaskFramework] {
        return generalItems
    }
    
    func getNumberofCategories() -> Int {
        return categories.count
    }
    
    func getNumberOfTasks() -> Int{
        var sum = 0
        for keys in categories.keys.sorted() {
            sum += categories[keys]!.count
        }
        
        return sum
    }
    
    func saveBucketList() {
        
    }
    
}
