//
//  InstructorManager.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/9/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class UserManager {
    
    private var user : User
    
    init(user : User) {
        self.user = user
    }
    
    // MARK: General Get Methods
    
    func getUser() -> User {
        return user
    }
    
    // MARK: STATIC CONSTANTS AND GET METHODS
    
    private static var instructorManager : UserManager!
    
    static func generateUserManager(withUser user : User) {
        instructorManager = UserManager(user: user)
    }
    
    static func getUserManager() -> UserManager {
        return instructorManager
    }
    
}
