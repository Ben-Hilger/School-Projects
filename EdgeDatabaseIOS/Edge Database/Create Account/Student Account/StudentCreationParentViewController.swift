//
//  StudentCreationParentViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 2/26/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class StudentCreationParentViewController : UITableViewController {
    
    var externalInfo : [ExternalContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return externalInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactInfo") as! LeftDetailTableViewCell
        
        cell.configureCell(withString: externalInfo[indexPath.row].name)
        
        return cell
        
    }
    
    @IBAction func addContactInfo(sender : Any) {
        
        let alert = AlertUtil.generateAlertViewController(withTitle: "Add Contact Info", withMessage: "Please enter the name, phone number and/or contact info of the contact below", withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Name...", "Enter Email... (optional)", "Enter Phone Number... (optional)"])
        
        let doneAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let name = alert.textFields?[0].text {
                
                let email = alert.textFields![1].text
                let phoneNumber  = alert.textFields![2].text
                
                let contactInfo = ExternalContact(withName: name, withPhoneNumber: phoneNumber ?? "", withEmail: email ?? "")
            
                self.externalInfo.append(contactInfo)
                self.tableView.reloadData()
            }
        
        }
        
        alert.addAction(doneAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func complete(sender : Any) {
    
        
        FirebaseUser.getFirebaseAccount().updateProfile(withUID: UserManager.getUserManager().getUser().uid, withName: UserManager.getUserManager().getUser().name, withLoginType: UserManager.getUserManager().getUser().accountType, externalContacts: externalInfo) { (success) in
            if success {
                UserManager.getUserManager().getUser().externalContacts = self.externalInfo as! NSMutableArray
                self.performSegue(withIdentifier: "toNavigation", sender: self)
            } else {
                let errorAlert = AlertUtil.generateAlertViewController(withTitle: "Erro", withMessage: "We were unable to process the information at this time, please try again later", withStyle: .alert, actions: [AlertUtil.doneAction])
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
        
    
    
    
}
