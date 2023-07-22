//
//  SignInViewController.swift
//  Bucket List
//
//  Created by Ben Hilger on 11/12/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignInViewController : UIViewController {
    
    @IBOutlet var userName : UITextField!
    @IBOutlet var password : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.keyboardType = .emailAddress
        password.isSecureTextEntry = true
        
    }
    
    @IBAction func loginUser(sender : Any) {
        if(userName.text != "" && password.text != ""){
            AppDelegate.permManager.loginUser(username: userName.text!, password: password.text!) { (isLoggedIn) in
                if(!isLoggedIn){
                    print("Unable to Login User")
                    let alert = UIAlertController(title: "Unable to login with credentials", message: "The username and password entered do not match any known accounts.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    print("User logged in, moving to main screen")
                    let docketViewController : DocketViewController = self.storyboard?.instantiateViewController(withIdentifier: "Docket") as! DocketViewController
                    
                    self.present(docketViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func createAccount(sender : Any){
        self.performSegue(withIdentifier: "ToCreateAccount", sender: self)
    }
    
    @IBAction func forgotPassword(sender : Any){
        
        let alert = UIAlertController(title: "Forgot Password", message: "Please enter the email account assocaited with our Bucket List account. If this email is within our system, an email will be sent explaining how to change your password.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Email..."
            textField.textAlignment = NSTextAlignment.left
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let send = UIAlertAction(title: "Send", style: .default, handler: { (s) in
            if let tf : UITextField = alert.textFields![0] {
                if(tf.text != ""){
                    Auth.auth().sendPasswordReset(withEmail: tf.text!, completion: { (err) in
                        if let error = err {
                            print(error.localizedDescription)
                        }else {
                            print("Sent Password Reset")
                            let alert2 = UIAlertController(title: "Forgot Password", message: "Your email has been sent! Check your inbox for further instructions!", preferredStyle: .alert)
                            alert2.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                            self.present(alert2, animated: true, completion: nil)
                        }
                    })
                }
            }
        })
        
        alert.addAction(cancel)
        alert.addAction(send)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userName.endEditing(true)
        password.endEditing(true)
    }
    
}
