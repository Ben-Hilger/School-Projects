//
//  CreateAccountMainMenuViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/24/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class CreateAccountMainMenuViewController : UIViewController {
    
    @IBOutlet var insturcbutton : UIButton!
    @IBOutlet var studButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FormatUtil.formatButton(forButton: insturcbutton)
        FormatUtil.formatButton(forButton: studButton)
        
    }
    
    @IBAction func toCreateInstructor(sender : Any) {
        self.performSegue(withIdentifier: "toCreatePart2", sender: LoginType.INSTRUCTOR)
    }
    
    @IBAction func toCreateStudent(sender : Any) {
        self.performSegue(withIdentifier: "toCreateStudent", sender: LoginType.STUDENT)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.elementsEqual("toCreatePart2") ?? false {
            let vc = segue.destination as! CreateAccountViewController
            vc.loginType = sender as? AccountType ?? AccountType.player
        }
    }
    
    @IBAction func unwindToCreateAccountMainMenu(_ unwindSegue: UIStoryboardSegue) {}
    
}
