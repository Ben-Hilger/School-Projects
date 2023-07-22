//
//  ExternalContactInfo.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 2/26/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation

class ExternalContactInfo {
    
    var name : String
    var phoneNumber : String?
    var email : String?
    
    init(withName n : String, withPhoneNumber pN : String? = nil, withEmail e : String? = nil) {
        name = n
        
        if let pN = pN {
            phoneNumber = pN
        }
        
        if let e = e {
            email = e
        }
    }
}
