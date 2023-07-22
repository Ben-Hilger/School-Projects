//
//  LoadingOverlay.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/5/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class AlertUtil {
    
    static let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
    static let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    static func generateActivityAlert(withMessage mess : String) -> UIAlertController {
       
        let alert = UIAlertController(title: nil, message: mess, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        
        return alert
    }
    
    static func generateAlertViewController(withTitle t: String?, withMessage m : String?, withStyle s : UIAlertController.Style, actions : [UIAlertAction]=[], withTextFieldPlaceholders tf : [String]=[]) -> UIAlertController {
        
        let alert = UIAlertController(title: t, message: m, preferredStyle: s)
        
        for action in actions {
            alert.addAction(action)
        }
        
        for placeholder in tf {
            alert.addTextField { (text) in
                text.placeholder = placeholder
            }
        }
        
        return alert
        
    }
}
