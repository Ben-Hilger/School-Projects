//
//  CreateAccountViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/21/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class CreateAccountViewController : UIViewController, SportSelectionDelegate {
    
    
    @IBOutlet var pageTitle : UINavigationItem!
    
    @IBOutlet var name : UITextField! // Stores the users entered name
    @IBOutlet var password: UITextField! // Stores the users desired password
    @IBOutlet var passwordVerify : UITextField! // Stores the users verifying password
    
    @IBOutlet var sportPlaying : UIButton!
    
    @IBOutlet var email : UITextField! // Stores the users email
    @IBOutlet var phoneNumber : UITextField! // Stores the users phone number
    
    var loginType : AccountType!
    
    var sportSelection : SportSelectionTableViewController?
    
    var sportTeaching : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let type = loginType {
            if type == AccountType.coach {
                pageTitle.title = "Create Instructor Account"
                sportPlaying.setTitle("Sport Teaching: \(FormatUtil.arrayToString(forArr: sportTeaching ?? ["None"]))", for: .normal)
            } else if type == AccountType.player {
                pageTitle.title = "Create Student Account"
                sportPlaying.setTitle("Sport Playing: \(FormatUtil.arrayToString(forArr: sportTeaching  ?? ["None"]))", for: .normal)
            }
        }
        
        phoneNumber.keyboardType = .numberPad // Changes the keyboard of the phone number box to a number pad, ensuring only numbers can be entered
        phoneNumber.placeholder = "(optional)"
        
        email.keyboardType = .emailAddress
        email.placeholder = "example@example.com"
        
        passwordVerify.isSecureTextEntry = true
        password.isSecureTextEntry = true
        
        FormatUtil.formatButton(forButton: sportPlaying)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    /**
        When the user activites this function, it attempts to crete an account using the information they entered in the text fields
     */
    @IBAction func createAccount(sender : Any) {
        
        self.present(AlertUtil.generateActivityAlert(withMessage: "Creating Account..."), animated: true) {
            // Checks to make sure all required fields are filled in
            if(self.name.text! == "" || self.password.text == "" || self.passwordVerify.text == "" ){
                self.name.layer.borderColor = self.name.text! == "" ? UIColor.red.cgColor : UIColor.black.cgColor
                self.password.layer.borderColor = self.password.text! == "" ? UIColor.red.cgColor : UIColor.black.cgColor
                self.passwordVerify.layer.borderColor = self.passwordVerify.text! == "" ? UIColor.red.cgColor : UIColor.black.cgColor
                self.dismiss(animated: true, completion: nil)
                return
            }
                   
            // Ensures that there are no problems getting the email, password, and verifying password from the text fields
            if let e = self.email.text, let p = self.password.text, let pV = self.passwordVerify.text, let name = self.name.text, let sports = self.sportTeaching {
                // Checks to make sure they entered
                if p.elementsEqual(pV) && name != "" {
                    FirebaseUser.getFirebaseAccount().createAccount(withEmail: e, withPassword: p, withName: name, sports: sports, withLoginType: self.loginType, withPhoneNumber: self.phoneNumber.text ?? "") { (created, errMess) in
                        if created {
                            
                            self.dismiss(animated: true) {
                                self.performSegue(withIdentifier: "toNavigation", sender: [UserManager.getUserManager().getUser(), ProfileType.Personal])
                            }
                            
                            
                        } else {
                            let alert : UIAlertController = AlertUtil.generateAlertViewController(withTitle: "Account Creatiokn", withMessage: errMess, withStyle: .alert, actions: [AlertUtil.doneAction])
                            
                            self.dismiss(animated: true) {
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    // Sets the border of the password and verify password box to red to signal to the user that they don't match
                    self.passwordVerify.layer.borderColor = UIColor.red.cgColor
                    self.passwordVerify.layer.borderWidth = 1
                    self.password.layer.borderColor = UIColor.red.cgColor
                    self.password.layer.borderWidth = 1
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func tapSport(sender : Any) {
                
        let sportSelec : SportSelectionTableViewController = self.storyboard?.instantiateViewController(identifier: "SportView") as! SportSelectionTableViewController
        sportSelec.selectedSports = sportTeaching ?? []
        sportSelec.delegate = self
        sportSelection = sportSelec
        self.present(sportSelec, animated: true, completion: nil)

    }
    
    func sportSelected(sport: [String]) {
        
        sportTeaching = sport
        sportPlaying.setTitle("Sport Teaching: \(sport.count > 0 ? FormatUtil.arrayToString(forArr: sport) : "None")", for: .normal)
        sportSelection?.dismiss(animated: true, completion: nil)
        sportSelection = nil
     }
    
    func cancel() {
        sportSelection?.dismiss(animated: true, completion: nil)
        sportSelection = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        name.endEditing(true)
        password.endEditing(true)
        passwordVerify.endEditing(true)
        email.endEditing(true)
        phoneNumber.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.elementsEqual("toNavigation") ?? false {
            let des = segue.destination as! NavigationController
            des.autoToProfile = true
            des.args = sender as! [Any]
        }
    }
}

