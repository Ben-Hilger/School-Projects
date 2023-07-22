//
//  ProfileViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 11/6/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class ProfileViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView : UITableView!

    @IBOutlet var imageView : UIImageView!
    
    @IBOutlet var name : UILabel!
    @IBOutlet var bio : UILabel!
    
    var sections : [String] = []
    var info : [[String]] = []
    var ids : [[String]] = []
    var userShowing : User?
    var showingType : ProfileType = .Other

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUser()
    }
    
    func setupUser() {
        
        if let user = userShowing {
            name.text = user.name
               
            if let bio = user.bio {
                self.bio.text = bio
            } else {
                if showingType == .Other {
                    bio.text = NO_BIO_FOUND_TAG
                } else {
                    bio.text = ADD_BIO_TAG
                }
            }
        
            if user.accountType == AccountType.coach {
                sections = [
                    CONTACT_INFO_TAG,
                    SPORT_TEACHING_TAG
                ]
            } else if user.accountType == AccountType.player {
                sections = [
                    CONTACT_INFO_TAG,
                    SPORT_PLAYING_TAG
                ]
            }

            let contactIDS : [String] = [EMAIL_TAG, PHONE_NUMBER_TAG, ADDRESS_TAG]

            var contact : [String] = [user.email]
        
            if let phoneNumber = user.phoneNumber {
                contact.append(phoneNumber)
            } else if showingType == .Personal {
                contact.append(ADD_PHONE_NUMBER_TAG)
            }
           
            if let address = user.address {
                contact.append(address)
            } else if showingType == .Personal {
                contact.append(ADD_ADDRESS_TAG)
            }
           
            info.append(contact)
            ids.append(contactIDS)
            info.append(user.sports as! [String])
            ids.append(user.sports as! [String])

            tableView.reloadData()
               
           }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: PROFILE_CELL_REUSE_ID) as! ProfileTableViewCell
        
        cell.setupCell(str: info[indexPath.section][indexPath.row], id : ids[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var numberOfEntries = sections.count
        
        for index in 0..<sections.count {
            numberOfEntries += info[index].count * 2
        }
        
        return (tableView.frame.height) / CGFloat(numberOfEntries) * 2
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        var numberofEntries = sections.count
        
        for index in 0..<sections.count {
            numberofEntries += info[index].count * 2
        }
        
        
        return (tableView.frame.height) / CGFloat(numberofEntries) * 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell : ProfileTableViewCell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
        
        if let text = cell.identifier {
            if showingType != .Personal {
                return
            }
            
            let user = UserManager.getUserManager().getUser()
            let uid = user.uid
            let accType = user.accountType
            
            if text.contains(EMAIL_TAG) {
                showChangeAlert(msg: "Enter the New Email Below") { (newEmail) in
                    if newEmail != "" {
                        //FirestoreManager.getFirestore().updateProfile(withUID: uid, userType: accType, withEmail: newEmail)
                        self.setupUser()
                    }
                }
            } else if text.contains(PHONE_NUMBER_TAG) {
                showChangeAlert(msg: "Enter the New Phone Number Below") { (newPN) in
                    if newPN != "" {
                        //FirestoreManager.getFirestore().updateProfile(withUID: uid, userType: accType, withPhoneNumber: newPN)
                        self.setupUser()
                    }
                }
            } else if text.contains(ADDRESS_TAG)  {
                showChangeAlert(msg: "Enter the New Address Below") { (newAdd) in
                    if newAdd != "" {
                    
                        //FirestoreManager.getFirestore().updateProfile(withUID: uid, userType: accType, withAddress: newAdd)
                        self.setupUser()
                    }
                }
            }
        }
       
        
    }
    
    func showChangeAlert(msg : String, completion : @escaping (String) -> Void) {
        
        let alert : UIAlertController = AlertUtil.generateAlertViewController(withTitle: "Update Profile", withMessage: msg, withStyle: .alert, actions: [AlertUtil.cancelAction], withTextFieldPlaceholders: ["Enter Updated Value"])
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Updated Value"
        }
        
        let done = UIAlertAction(title: "Update", style: .default) { (action) in
            completion(alert.textFields![0].text!)
        }
        
        alert.addAction(done)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func openMenu(sender : Any) {
        (SidebarLauncher(delegate: self)).show()
    }
    
    
    private let PHONE_NUMBER_TAG = "Phone Number"
    private let ADD_PHONE_NUMBER_TAG = "Click Here to Add a Phone Number!"
    
    private let ADDRESS_TAG = "Address"
    private let ADD_ADDRESS_TAG = "Click Here to Add an Address!"
    
    private let EMAIL_TAG = "Email"

    private let ADD_BIO_TAG = "Click Here to Add a Biography"
    private let NO_BIO_FOUND_TAG = "The User Hasn't Added a Biography Yet"
    
    private let CLICK_TO_CHANGE_TAG = "(Click Here to Change it!)"
    private let CONTACT_INFO_TAG = "Contact Info"
    private let SPORT_TEACHING_TAG = "Sport Teaching"
    private let SPORT_PLAYING_TAG = "Sport Playing"
    
    private let PROFILE_CELL_REUSE_ID = "ProfileCell"
}

enum ProfileType {
    case Personal
    case Other
}

extension ProfileViewController : SideBarDelegate {
    
    func sidebarDidOpen() {
        print("Sidebar Opened")
    }
    
    func sidebarDidClose(with item: Int?) {
        guard let item = item else {return}
        print("Did select \(item)")
        switch item {
        case 0: // Profile, which is already showing
            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profile = segue.destination as! ProfileViewController
        
        if let items : [Any] = sender as? [Any] {
            profile.userShowing = items[0] as? User
            profile.showingType = items[1] as! ProfileType
            profile.setupUser()
        }
    }
    
}
