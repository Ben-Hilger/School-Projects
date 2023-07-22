//
//  StudentCreationPersonalInformation.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 2/25/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class StudentCreationPersonalInformationViewController : UIViewController {
    
    @IBOutlet var name : UITextField!
    @IBOutlet var phoneNumber : UITextField!
    @IBOutlet var birthday : UIDatePicker!
    @IBOutlet var highSchool : UITextField!
    @IBOutlet var summerTeam : UITextField!
    @IBOutlet var graduationYear : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Formats the date picker
        FormatUtil.formatDatePicker(forDatePicker: birthday)
        
    }
    
    @IBAction func completed(sender : Any) {
        // Checks to see if it can read from the user input
        if let name = name.text, let pN = phoneNumber.text, let gradYear = graduationYear.text, let highSchool = highSchool.text, let summerTeam = summerTeam.text {
            // Stores the beginning of the users information
            let user = UserManager.getUserManager().getUser()
            // Updates the user's profile on Firebase
            FirebaseUser.getFirebaseAccount().updateProfile(withUID: user.uid, withName: name, withLoginType: AccountType.player, withBio: "", withAddress: "", sports: [], withPhoneNumber: pN, gradYear: Int(gradYear) ?? 2020, summerTeam: summerTeam, highSchoolTeam: highSchool, externalContacts: [], withTeamCodes: []) { (success) in
                if success {
                    // Updates the information locally
                    user.name = name
                    user.phoneNumber = pN
                    user.graduationYear = gradYear
                    user.highSchoolTeam = highSchool
                    user.summerTeam = summerTeam
                    // Takes the user to the next step in the information
                    self.performSegue(withIdentifier: "toParentInformation", sender: self)
                } else {
                    // Generates an alert to inform the user there was an issue
                    let alert = AlertUtil.generateAlertViewController(withTitle: "Unable to process information", withMessage: "There was an issue saving the information, please try again another time", withStyle: .alert, actions : [AlertUtil.doneAction])
                    // Presents the information to the user
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
