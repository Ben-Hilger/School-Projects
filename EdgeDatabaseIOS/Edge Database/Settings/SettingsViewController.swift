//
//  SettingsViewController.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/23/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class SettingsViewController : UITableViewController {
    
    @IBAction func changeUsername(sender : Any) {
        // Generates an alert to prompt the user to enter their current username
        let changeAlert = AlertUtil.generateAlertViewController(withTitle: "Change Username", withMessage: "To begin, please enter your current username below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Current Username...."])
        // Creates a retry action if they fail at any point
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (act) in
            // Represents the changeAlert =
            self.present(changeAlert, animated: true, completion: nil)
        }
        // Ceates a done action once the user finished entering their username
        let doneAlert = UIAlertAction(title: "Done", style: .default) { (action) in
            // Checks if there's valid username text to use
            if let text = changeAlert.textFields?[0].text {
                // Checks if the entered username is equal to their current username
                if text == UserManager.getUserManager().getUser().username {
                    // Generates an alert for the user to enter their new passwoed
                    let newUserNAlert = AlertUtil.generateAlertViewController(withTitle: "Change Username", withMessage: "Please enter a new username below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter New Username..."])
                    // Creates a done action once the user has been able to enter their new username
                    let done = UIAlertAction(title: "Done", style: .default) { (action) in
                        // Checks if there's valid text to analyze
                        if let newUserN = newUserNAlert.textFields?[0].text {
                            // Generates an activity to inform the user that their username is being changed
                            let changingActivity = AlertUtil.generateActivityAlert(withMessage: "Changing Username...")
                            // Presents the activity alert to the user
                            self.present(changingActivity, animated: true) {
                                // Attempts to change the username of the user
                                FirebaseUser.getFirebaseAccount().changeUsername(currentUsername: UserManager.getUserManager().getUser().username, newUsername: newUserN) { (success) in
                                    // Checks if it was successfull
                                    if success {
                                        // Changes the message to reflect the success
                                        newUserNAlert.message = "Username changed successfully!"
                                        // Dismisses the changingActivity alert
                                        self.dismiss(animated: true) {
                                            // Presents an alert to the user that the username was successfully changed
                                            self.present(AlertUtil.generateAlertViewController(withTitle: nil, withMessage: "Username changed successfully!", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
                                        }
                                    } else {
                                        // Dismisses the changingActivity alert
                                        self.dismiss(animated: true) {
                                            // Presents an alert to the user that the username wasn't changed
                                            self.present(AlertUtil.generateAlertViewController(withTitle: "Changing Username", withMessage: "There was an issue changing the username, the username you entered could already be in use", withStyle: .alert, actions: [AlertUtil.cancelAction, retryAction]), animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // Adds the done action  to the newUserNAlert
                    newUserNAlert.addAction(done)
                    // Presents the newUserNAlert to the user
                    self.present(newUserNAlert, animated: true, completion: nil)
                } else {
                    // Presents an alert to the user that informs then an incorrect username was entered
                    self.present(AlertUtil.generateAlertViewController(withTitle: "Change Username", withMessage: "An incorrect username was entered, please try again", withStyle: .alert, actions: [retryAction, AlertUtil.cancelAction]), animated: true, completion: nil)
                }
            }
        }
        // Adds the done alert to the changeAlert
        changeAlert.addAction(doneAlert)
        // Presents the changeAlert to the user
        self.present(changeAlert, animated: true, completion: nil)
    }
    
    @IBAction func changePassword(sender : Any) {
        // Attempts to send a password reset to the user's email
        FirebaseUser.getFirebaseAccount().sendPasswordReset(withEmail: UserManager.getUserManager().getUser().email) { (success, error) in
            // Checks if it was a success
            if success {
                // Presents an alert to the user informing them that it was successfull in sending the email
                self.present(AlertUtil.generateAlertViewController(withTitle: "Change Password", withMessage: "A password reset email has been sent, check your email for the link to change your password", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
            } else {
                // Presents an alert to the user informing them that it wasn't able to send the email
                self.present(AlertUtil.generateAlertViewController(withTitle: "Change Password", withMessage: "There was an issue sending a password reset email, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction]), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func logOut(sender : Any) {
        // Logsout the user
        FirebaseUser.getFirebaseAccount().logout {_ in
            // Takes the user main to the main menu when the app first opens
            let logIn = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! MainMenuViewController
            WindowUtil.makeViewControllerKey(viewController: logIn)
        }
    }
    
    @IBAction func openMenu(sender : Any) {
        // Presents the navigation sidebar to the user
        (SidebarLauncher(delegate: self)).show()
    }
}

extension SettingsViewController : SideBarDelegate {
    func sidebarDidOpen() {}
    
    func sidebarDidClose(with item: Int?) {}
}
