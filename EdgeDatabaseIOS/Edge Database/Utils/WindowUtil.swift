//
//  WindowUtil.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/13/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class WindowUtil {
    
    static func makeViewControllerKey(viewController vc : UIViewController) {
        
        UIApplication.shared.windows[0].rootViewController = vc
        
    }
    
    
}
