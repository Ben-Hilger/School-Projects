//
//  ViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/12/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet var instructorButton : UIButton!
    @IBOutlet var studentButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FormatUtil.formatButton(forButton: instructorButton)
        FormatUtil.formatButton(forButton: studentButton)
        
    }

    @IBAction func signInInstructor(sender : Any) {
        
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    @IBAction func toCreateAccount(sender : Any) {
       
        self.performSegue(withIdentifier: "toCreateAcc", sender: self)
        
    }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {}
    
}

