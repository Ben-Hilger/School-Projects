//
//  CreateAccountViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 11/13/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController : UIViewController {
    
    @IBOutlet var displayName : UITextField!
    
    @IBOutlet var email : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var reenterPassword : UITextField!
    
    let permManager: PermissionManager = AppDelegate.permManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.keyboardType = .emailAddress
        password.isSecureTextEntry = true
        reenterPassword.isSecureTextEntry = true
    }
    
    
    @IBAction func createAccount(sender : Any){
        if(reenterPassword.text != password.text){
            let alert = UIAlertController(title: "Passwords Must Match", message: "The passwords you entered didn't match. Please fix before continuing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if(reenterPassword.text == "" || password.text == "" || displayName.text == "" || email.text == "" ){
            let alert = UIAlertController(title: "Enter All Fields", message: "Some of the fields aren't filled, please fill them before continuing.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if let username = email.text, let pass = password.text, let dn = displayName.text {
            permManager.createUser(username: username, password: pass)
            let values : [String : String] = [permManager.USER_DISPLAY_NAME_ID : dn]
            permManager.updateBasicAccountInfo(infoToUpdate: values)
            
            let alert = UIAlertController(title: "Account Created", message: "Sorry, but something went wrong when creating your account, please try again or come back later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Unable to Create Account", message: "Sorry, but something went wrong when creating your account, please try again or come back later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func returnToLogin(sender : Any){
        self.performSegue(withIdentifier: "ToLogin", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        displayName.endEditing(true)
        email.endEditing(true)
        password.endEditing(true)
        reenterPassword.endEditing(true)
    }
    
}
