//
//  NewNavigationController.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 12/6/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class NavigationController : UIViewController {
    
    @IBOutlet var image : UIImageView!
    @IBOutlet var name : UILabel!
    
    @IBOutlet var viewProfileButton : UIButton!
    @IBOutlet var lessonPlanningButton : UIButton!
    @IBOutlet var settingsButton :  UIButton!
    
    var delegate : NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUser() {
    
        name.text = UserManager.getUserManager().getUser().name
        
        FormatUtil.formatButton(forButton: viewProfileButton)
        FormatUtil.formatButton(forButton: settingsButton)
        FormatUtil.formatButton(forButton: lessonPlanningButton)

    }
    
    func didSelect(_ sender: Int){
        delegate?.navigation(didSelect: sender)
    }

    @IBAction func CloseMenu(_ sender: Any) {
        delegate?.navigation(didSelect: nil)
    }
    
    @IBAction func viewProfile(sender : Any) {
            
        CloseMenu(self)
        self.performSegue(withIdentifier: "toProfile", sender: [UserManager.getUserManager().getUser(), ProfileType.Personal])

    }
    
    @IBAction func toLessonPlanneer(sender : Any) {
        CloseMenu(self)
        if UserManager.getUserManager().getUser().accountType == AccountType.coach {
            self.performSegue(withIdentifier: "toLessonPlanner", sender: self)
        } else {
            // TODO: FIX SENDER
            self.performSegue(withIdentifier: "toHomework", sender: UserManager.getUserManager().getUser())
        }
     
        
    }
    
    var autoToProfile = false
    var args : [Any] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier?.elementsEqual("toProfile") ?? false {
            let destination = segue.destination as! ProfileViewController
            
            let sender : [Any] = sender as! [Any]
            
            destination.userShowing = sender[0] as? User
            destination.showingType = sender[1] as! ProfileType
            
        } else if segue.identifier?.elementsEqual("toHomework") ?? false {
            let destination = segue.destination as! LessonScheduleViewController
        }
    }

    @IBAction func goToSettings(sender : Any) {
        let settings = UIStoryboard.init(name: "Navigation", bundle: Bundle.main).instantiateViewController(identifier: "Settings") as! SettingsViewController
        WindowUtil.makeViewControllerKey(viewController: settings)
    }
    
    @IBAction func goToTeams(sender : Any) {
        let teams = UIStoryboard(name: "Team", bundle: Bundle.main).instantiateInitialViewController() as! UITabBarController
        WindowUtil.makeViewControllerKey(viewController: teams)
    }
    
}

protocol NavigationDelegate {
    func navigation(didSelect: Int?)
    
}
