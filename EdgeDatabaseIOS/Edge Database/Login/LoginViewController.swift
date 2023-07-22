//
//  LoginViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/13/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController : UIViewController {
    
    @IBOutlet var titleBar : UINavigationItem!
    
    @IBOutlet var email : UITextField!
    @IBOutlet var password : UITextField!
    
    @IBOutlet var login : UIButton!
    @IBOutlet var createAcc : UIButton!
    @IBOutlet var forgotPass : UIButton!
    
    var loginType : LoginType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lT = loginType {
            if lT == .INSTRUCTOR {
                titleBar.title = "Instructor Login"
            } else {
                titleBar.title = "Student Login"
            }
        }
        
        email.keyboardType = .emailAddress
        password.isSecureTextEntry = true
        
        FormatUtil.formatButton(forButton: login)
        FormatUtil.formatButton(forButton: createAcc)
        FormatUtil.formatButton(forButton: forgotPass)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        email.endEditing(true)
        password.endEditing(true)
    }
    
    @IBAction func login(sender : Any) {
        
        let overViewAlert = AlertUtil.generateActivityAlert(withMessage: "Logging you in...")
        
        present(overViewAlert, animated: true) {
            if let username = self.email.text, let pass = self.password.text {
                FirebaseUser.getFirebaseAccount().loginUser(withEmail: username, withPassword: pass, completion: { (isLoggedIn, errMess) in
                    if(!isLoggedIn){
                                
                        let alert = AlertUtil.generateAlertViewController(withTitle: "Unable to Login", withMessage: errMess, withStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                        
                        self.dismiss(animated: true) {
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                               
                    }else{
                        overViewAlert.message = "Logged in, opening profile..."
                        
                        self.dismiss(animated: true) {
                            
                            let navigationController : UITabBarController = UIStoryboard(name: "Team", bundle: Bundle.main).instantiateInitialViewController() as! UITabBarController
                            if UserManager.getUserManager().getUser().username == "" {
                                let setUsername = AlertUtil.generateAlertViewController(withTitle: "Select Username", withMessage: "Please set a username for your account. This can be used to be invited to a team", withStyle: .alert, withTextFieldPlaceholders: ["Enter Username..."])
                                let retryAction = UIAlertAction(title: "Retry", style: .default) { (act) in
                                    self.dismiss(animated: true) {
                                        self.present(setUsername, animated: true, completion: nil)
                                    }
                                }
                                let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
                                    let usernameActivity = AlertUtil.generateActivityAlert(withMessage: "Setting Username...")
                                        self.present(usernameActivity, animated: true) {
                                            if let text = setUsername.textFields?[0].text {
                                                if text == "" {
                                                    let invalidUsername = AlertUtil.generateAlertViewController(withTitle: "Select Username", withMessage: "Please enter a valid userame", withStyle: .alert, actions: [retryAction])
                                                    self.dismiss(animated: true) {
                                                        self.present(invalidUsername, animated: true, completion: nil)
                                                    }
                                                } else {
                                                    FirebaseUser.getFirebaseAccount().setUsername(withUID: UserManager.getUserManager().getUser().uid, username: text) { (success) in
                                                        print(success)
                                                        if success {
                                                            let done = UIAlertAction(title: "Done", style: .default) { (act) in
                                                                WindowUtil.makeViewControllerKey(viewController: navigationController)
                                                            }
                                                            let successAlert = AlertUtil.generateAlertViewController(withTitle: "Select Username", withMessage: "Username set successfully!", withStyle: .alert, actions: [done])
                                                            self.dismiss(animated: true) {
                                                                self.present(successAlert, animated: true, completion: nil)
                                                            }
                                                        } else {
                                                            self.dismiss(animated: true) {
                                                                self.present(AlertUtil.generateAlertViewController(withTitle: "Select Username", withMessage: "There was an issue settting the desired username, please try a different name", withStyle: .alert, actions: [retryAction]), animated: true, completion: nil)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        
                                    }
                                }
                                setUsername.addAction(doneAction)
                                self.present(setUsername, animated: true, completion: nil)
                            } else {
                                WindowUtil.makeViewControllerKey(viewController: navigationController)

                            }
                            
                        }
                                   
                    }
                })
            }
        }
    }
    
    @IBAction func createAccount(sender : Any) {
        self.performSegue(withIdentifier: "toCreateAccount", sender: "toLogin")
    }
    
    @IBAction func forgotPassword(sender : Any) {
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alert = AlertUtil.generateAlertViewController(withTitle: "Forgot Password", withMessage: "Please enter the email account assocaited with our Lessons Notebook account. If this email is within our system, an email will be sent explaining how to change your password.", withStyle: .alert, actions: [cancel], withTextFieldPlaceholders: ["Enter Email..."])
        
        let send = UIAlertAction(title: "Send", style: .default, handler: { (s) in
            if let tf : String = alert.textFields?[0].text {
                FirebaseUser.getFirebaseAccount().sendPasswordReset(withEmail: tf) { (sent, errMess) in
                    if(sent) {
                        let alert2 = UIAlertController(title: "Forgot Password", message: "Your email has been sent! Check your inbox for further instructions!", preferredStyle: .alert)
                        alert2.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                            self.present(alert2, animated: true, completion: nil)
                    } else {
                        let alert2 = UIAlertController(title: "Forgot Password", message: "The following problem was encountered: \n" + errMess! + "\n Please try again later", preferredStyle: .alert)
                        alert2.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                        self.present(alert2, animated: true, completion: nil)
                    }
                  }
              }
          })
            
        alert.addAction(send)
              
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.elementsEqual("toNavigation") ?? false {
            let des = segue.destination as! NavigationController
            des.autoToProfile = true
            des.args = sender as! [Any]
        }
        
    }
    
}

enum LoginType {
    case INSTRUCTOR
    case STUDENT
    
    func toString() -> String {
        switch(self) {
        case .INSTRUCTOR:
            return "Instructor"
        case .STUDENT:
            return "Student"
        }
    }
}
