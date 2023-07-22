//
//  SelectedViewController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 11/17/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit

class SelectedViewController : UIViewController {
   

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let profile : ProfileViewController = self.storyboard?.instantiateViewController(identifier: "Profile") as! ProfileViewController
//        profile.userShowing = User.getCurrentUser()
//        profile.showingType = .Personal
//        self.present(profile, animated: true, completion: nil)
//
    }
       
    @IBAction func openMenu(sender : Any) {
        
        (SidebarLauncher(delegate: self)).show()
    }
}


extension SelectedViewController : SideBarDelegate {
    
    func sidebarDidOpen() {
        print("Sidebar Opened")
    }
    
    func sidebarDidClose(with item: Int?) {
        guard let item = item else {return}
        print("Did select \(item)")
        switch item {
        case 0:
            self.performSegue(withIdentifier: "toProfile", sender: [UserManager.getUserManager().getUser(), ProfileType.Personal])
//            // Profile
//            let profile : ProfileViewController = self.storyboard?.instantiateViewController(identifier: "Profile") as! ProfileViewController
//            profile.userShowing = User.getCurrentUser()
//            profile.showingType = .Personal
//            profile.setupUser()
//            self.present(profile, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    
}
