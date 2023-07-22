//
//  StudentCreateAccountLoginViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 2/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class StudentCreateAccountLoginViewController : UIViewController {
    
    @IBOutlet var email : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var verifyPassword : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configures the text entries
        email.keyboardType = .emailAddress
        password.isSecureTextEntry = true
        verifyPassword.isSecureTextEntry = true
    }
    
    @IBAction func complete(sender : Any) {
        // Checks to make sure that it can read from the interface
        if let email = email.text, let password = password.text, let verify = verifyPassword.text {
            // Checks if the user missed any information
            if email.elementsEqual("") || password.elementsEqual("") || verify.elementsEqual("") {
                // Generates an alert to inform the user information is missing
                let alert = AlertUtil.generateAlertViewController(withTitle: "Missing Information", withMessage: "Please enter all of the necessary information to continue", withStyle: .alert, actions: [AlertUtil.doneAction])
                // Changes the border if the specified element is empty (red = empty, black otherwise)
                if (email.elementsEqual("")) { self.email.layer.borderColor = UIColor.red.cgColor }
                    else {self.email.layer.borderColor = UIColor.black.cgColor}
                if (password.elementsEqual("")) { self.password.layer.borderColor = UIColor.red.cgColor }
                    else { self.password.layer.borderColor = UIColor.black.cgColor }
                if (verify.elementsEqual("")) { self.verifyPassword.layer.borderColor = UIColor.red.cgColor }
                    else { self.verifyPassword.layer.borderColor = UIColor.black.cgColor }
                // Presents the new alert to the  user
                self.present(alert, animated: true, completion: nil)
            } else {
                // Creates an activity alert for creating the account
                let activityAlert = AlertUtil.generateActivityAlert(withMessage: "Creating Account...")
                // Presents the activity alert to the user
                self.present(activityAlert, animated: true) {
                    // Creates the account
                    FirebaseUser.getFirebaseAccount().createAccount(withEmail: email, withPassword: password, withName: "", sports: [], withLoginType: AccountType.player) { (created, error) in
                        // Checks to see if the account was created
                        if !created {
                            // Creates an alert to inform the user of the error
                            let alert = AlertUtil.generateAlertViewController(withTitle: nil, withMessage: error, withStyle: .alert, actions: [AlertUtil.doneAction])
                            // Dismisses the activity alert
                            self.dismiss(animated: true) {
                                // Presents the alert to the user
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            // Changes the activity alert message to indicate the account is created
                            activityAlert.message = "Account Created"
                            // Dismisses the activity alert
                            self.dismiss(animated: true) {
                                // Moves the user to the personal information page
                                self.performSegue(withIdentifier: "toPersonalInformation", sender: self)
                            }
                            
                        }
                                       
                    }
                }
            }
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.elementsEqual("toPersonalInformation") ?? false{
            
            
            
            
        }
        
        
    }
    
}
