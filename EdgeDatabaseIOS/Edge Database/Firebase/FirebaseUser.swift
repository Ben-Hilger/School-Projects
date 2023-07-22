//
//  FirebaseAccount.swift
//
//  This file is responsible for the user functions of firebase, which include:
//  Logging in, Creating Account, Forgot Password
//  Updating Profile Info
//  Loading Profile Info
//
//  Created by Benjamin Hilger on 10/21/19.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import Firebase
import SharedCode

class FirebaseUser {
    
    // Stores the running instance of the firebase account manager
    private static var instance : FirebaseUser = FirebaseUser()
        
    /**
        Returns the FirebaseAccount manager instance of the app
     */
    static func getFirebaseAccount() -> FirebaseUser {
        return instance
    }
    
    /**
        Login's in the user with the specified  email and password, and returns if it login was
        successful and any error messages if necessary
     */
    func loginUser(withEmail e : String,
                   withPassword p : String,
                   completion: @escaping (Bool, String?) -> Void) {
       
        // Checks to make sure that neither field is blank
        if e == "" || p == "" {
            // Reports to the client that one or both fields are blank
            completion(false, "Email or Password left blank")
        } else {
            // Attemps to login the user with the specified email and password
            Auth.auth().signIn(withEmail: e,
                               password: p) { (user, error) in
                // Checks to see if the login was successful
                if let error = error {
                    // Reports to the client there was an error
                    completion(false,
                               error.localizedDescription)
                } else {
                    if let uid = user?.user.uid {
                        self.loadUser(withUID: uid) { (user) in
                            
                            DispatchQueue.main.async {
                                if let user = user {
                                    UserManager.generateUserManager(
                                        withUser: user)
                                    completion(true,
                                               nil)
                                } else {
                                    completion(false,
                                "User doesn't exists, yet can be logged in??")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /**
        Sends  a password reset to the specified email, and reports to the user if it was successful
     and any error message if needed
     */
    func sendPasswordReset(withEmail e : String,
                           completion: @escaping (Bool, String?) -> Void) {
        // Checks to make sure the email field isn't blan
        if(e != ""){
            // Attempts to send the password reset email
            Auth.auth().sendPasswordReset(withEmail: e, completion: { (err) in
                // Checks to see if there was an error
                if let error = err {
                    // Reports there was an error to the user
                    completion(false, error.localizedDescription)
                }else {
                     // Reports the email was sent succeessfully
                    completion(true, nil)
                }
            })
        } else {
            // Reports to the user the email field was left blank
            completion(false, "Email left blank")
        }
    }
    
    /**
        Creates an email account and populates it with the necessary informtion, reports the result
     and any errors that occure
     */
    func createAccount(withEmail e : String,
                       withPassword p : String,
                       withName name : String,
                       sports : [String],
                       withLoginType t : AccountType,
                       withPhoneNumber pN : String = "",
                       completion : @escaping (Bool, String?) -> Void) {
        
        // Attempts to create the user with the given email and password
        Auth.auth().createUser(withEmail: e, password: p) { (user, error) in
            // Checks to see if there was an error
            if let error = error {
                // Reports there was an error to the user
                completion(false, error.localizedDescription)
            } else {
                let user = SharedCode.User(u: (user?.user.uid)!,
                                           lT: t,
                                           n: name,
                                           s: sports as! NSMutableArray,
                                           e: e,
                                           pN: pN,
                                           add: "",
                                           bio: "")
                UserManager.generateUserManager(withUser: user)
                // Reports to the user the login was successful
                completion(true, nil)
            }
        }
    }
    
    func logout(completion : (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print("Unable to logout")
        }
        
    }
    
    // MARK: Profile
       
    func updateProfile(withUID id : String,
                       withName name : String,
                       withEmail email : String = "",
                       withLoginType tY : AccountType,
                       withBio bio : String = "",
                       withAddress add : String = "",
                       sports : [String] = [],
                       withPhoneNumber pN : String = "",
                       gradYear : Int? = nil,
                       summerTeam : String? = nil,
                       highSchoolTeam : String? = nil,
                       externalContacts : [ExternalContact] = [],
                       withTeamCodes teamCodes : [String] = [],
                       completion : @escaping (Bool) -> Void) {
        // Stores the Firebase keys from the shared library
        let keys = FirebaseKeys()
        // Stores the information to send to Firebase to update
        var info : [String : Any] = [:]
        // Adds the specified account type to the update list
        info.updateValue(tY == AccountType.coach ? "Coach" : "Player",
                         forKey: keys.userAccountTypeKey)
        // Checks if the user entered a valid name
        if !name.elementsEqual("") {
            // Adds the name to the update list
            info.updateValue(name, forKey: keys.userNameKey)
        }
        // Checks if the user entered a valid email
        if !email.elementsEqual("") {
            // Adds the email to the update list
            info.updateValue(email, forKey: keys.userEmailKey)
        }
        // Checks if the user entered in a valid bio
        if !bio.elementsEqual("") {
            // Adds the specified bio to the update list
            info.updateValue(bio, forKey: keys.userBioKey)
        }
        // Checks if the user entered in a valid address
        if !add.elementsEqual("") {
            // Adds the specified address to the update list
            info.updateValue(add, forKey: keys.userAddressKey)
        }
        // Checks if the user entered in a valid phone number
        if !pN.elementsEqual("") {
            // Adds the specified phone number to the update list
            info.updateValue(pN, forKey: keys.userPhoneNumberKey)
        }
        // Checks if the user entered in any sports
        if sports.count > 0 {
            // Adds the specified sports to the update list
            info.updateValue(sports, forKey: keys.userSportsKey)
        }
        // Checks if the user has any team codes
        if  teamCodes.count > 0 {
            // Adds the specified team codes to the update list
            info.updateValue(teamCodes, forKey: keys.userTeamCodeKey)
        }
        // Checks if the user is a player
        if tY == AccountType.player {
            // Checks if there is a valid grad year
            if let gradYear = gradYear {
                // Adds the specified grad year to the update list
                info.updateValue(gradYear, forKey: keys.studentGradYearKey)
            }
            // Checks if there is a valid high school team
            if let highSchoolTeam = highSchoolTeam {
                info.updateValue(highSchoolTeam,
                                 forKey: keys.studentHighSchoolTeamKey)
            }
            // Checks to see if there is external contacts to set
            if externalContacts.count > 0 {
                var contacts : [Int : [String : String]] = [:]
                // Explores the list of contacts
                for contact in externalContacts {
                    contacts.updateValue([
                        keys.studentExternalContactNameKey : contact.name,
                        keys.studentExternalContactEmailKey : contact.email,
                        keys.studentExternalContactPhoneNumberKey :
                            contact.phoneNumber
                    ], forKey: contacts.count)
                }
                info.updateValue(contacts, forKey:
                    keys.studentExternalContactsKey)
            }
        }
        // Updates the profile information on Firebase
        FirebaseCore.instance.updateWithTransaction(collection: id,
                                        document: keys.profileInformationKey,
                                        information: info) { (success) in
            completion(success)
        }
    }
    
    func loadUser(withUID id : String,
                      completion : @escaping (SharedCode.User?) -> ()) {
        // Stores the Firebase keys from the shared library
        let keys = FirebaseKeys()
        FirebaseCore.instance.readInformation(collection: id,
                                        document: keys.profileInformationKey)
        { (information) in
            // Checks if the information exists
            if let data = information {
                // Gets all of the relevant information from Firebase
                let name : String = data[keys.userNameKey] as? String ?? ""
                let bio : String = data[keys.userBioKey] as? String ?? ""
                let email : String = data[keys.userEmailKey] as? String ?? ""
                let sports : [String] = data[keys.userSportsKey] as? [String] ?? []
                let address : String = data[keys.userAddressKey] as? String ?? ""
                let phoneNumber : String = data[keys.userPhoneNumberKey] as? String ?? ""
                let username : String = data[keys.usernameKey] as? String ?? ""
                let teamCodes : [String] = data[keys.userTeamCodeKey] as? [String] ?? []
                // Sets the account type of the usser
                var accType : AccountType = AccountType.player
                // Checks if the user has a set account type on firebase
                if let lT : String = data[keys.userAccountTypeKey] as? String {
                    // Checks if the user is an instructor
                    if lT.elementsEqual("Coach") {
                        // Changes the account type accordingly
                        accType = AccountType.coach
                    }
                }
                // Creates a user instance
                let user = SharedCode.User(u: id,
                                           lT: accType,
                                           n: name,
                                           s: NSMutableArray(array: sports),
                                           e: email,
                                           pN: phoneNumber,
                                           add: address,
                                           bio: bio)
                user.username = username
                user.teamCodes = NSMutableArray(array: teamCodes)
                // Checks if the user is a player
                if user.accountType == AccountType.player {
                    let summerTeam : String = data[keys.studentSummerTeamKey] as? String ?? ""
                    let gradYear : Int = data[keys.studentGradYearKey] as? Int ?? 2000
                    let highSchoolTeam : String = data[keys.studentHighSchoolTeamKey] as? String ?? ""
                    // Stores the information for the contacts stored on Firebase
                    let contacts : [Int : Any] = data[keys.studentExternalContactsKey] as? [Int : Any] ?? [:]
                    // Stores the contact information
                    var externalContacts : [ExternalContact] = []
                    // Explores the list of contacts from Firebase
                    for contact in contacts {
                        let info = contact.value as? [String : String] ?? [:]
                        // Gets the name from the array
                        let name = info[keys.studentExternalContactNameKey]
                        // Gets the phone number from the array
                        let phonenumber = info[keys.studentExternalContactPhoneNumberKey]
                        // Gets the email from the array
                        let email = info[keys.studentExternalContactEmailKey]
                        // Creates an instance to store the contact information
                        let finalContact = ExternalContact(withName: name ?? "",
                                                           withPhoneNumber: phonenumber ?? "",
                                                           withEmail: email ?? "")
                        // Adds the contact to the list
                        externalContacts.append(finalContact)
                    }
                    user.summerTeam = summerTeam
                    user.graduationYear = "\(gradYear)"
                    user.highSchoolTeam = highSchoolTeam
                    user.externalContacts = NSMutableArray(array: externalContacts)
                    
                }
                // Returns the finished user through the completion statemeent
                completion(user)
            } else {
                // Returns a nil statement
                completion(nil)
            }
        }
    }
    
    func setUsername(withUID uid : String, username : String, completion : @escaping (Bool) -> ()) {
        // Stores the Firebase keys from the shared library
        let keys = FirebaseKeys()
        // Loads all of the usernames
        loadUsernameRegistry { (usernames) in
            print(usernames)
            // Checks to see if the username is already used
            if usernames.contains(username) {
                // Returns false since the username was already used
                completion(false)
            } else {
                // Attempts to update the username registry
                FirebaseCore.instance.setDataForce(collection: keys.userNameInformationKey, document: username, information: [keys.usernameUIDKey : uid]) { (success) in
                    if success {
                        // Attempts to update the user's information
                        FirebaseCore.instance.updateWithTransaction(collection: uid, document: keys.profileInformationKey, information: [keys.usernameKey : username]) { (success) in
                            // Sets the username of the user logged in
                            UserManager.getUserManager().getUser().username = username
                            completion(success)
                        }
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    
    
    func loadUsernameRegistry(completion : @escaping ([String]) -> ()) {
        // Stores the Firebasse keys from the shared library
        let keys = FirebaseKeys()
        // Reads the username register from Firebase
        let firestore = Firestore.firestore()
        firestore.collection(keys.userNameInformationKey).getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
            } else {
                if let documents = snapshot?.documents {
                    var names : [String] = []
                    for document in documents {
                        names.append(document.documentID)
                    }
                    completion(names)
                }
            }
        }
    }
    
    func inviteUser(toTeam teamCode : String, withUsername username : String, completion : @escaping (Bool) -> ()) {
        loadUsernameRegistry { (usernames) in
            print(usernames)
            if usernames.contains(username) {
                print("HERE")
                let keys = FirebaseKeys()
                FirebaseCore.instance.readInformation(collection: keys.userNameInformationKey, document: username) { (information) in
                    if let information = information {
                        var currentInvites = information["Team_Invites"] as? [String] ?? []
                        if !currentInvites.contains(teamCode) {
                            currentInvites.append(teamCode)
                        }
                        FirebaseCore.instance.updateWithTransaction(collection: keys.userNameInformationKey, document: username, information: ["Team_Invites" : currentInvites]) { (success) in
                            completion(success)
                        }
                        completion(true)
                    } else {
                        FirebaseCore.instance.updateWithTransaction(collection: keys.userNameInformationKey, document: username, information: ["Team_Invites" : [teamCode]]) { (success) in
                            completion(success)
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    func loadTeamInvitations(forUsername name : String, completion : @escaping ([String : String]) -> ()) {
        let keys = FirebaseKeys()
        FirebaseCore.instance.readInformation(collection: keys.userNameInformationKey , document: name) { (information) in
            if let information = information {
                let currentInvites = information["Team_Invites"] as? [String] ?? []
                var names : [String : String] = [:]
                if names.count == 0 {
                    completion([:])
                }
                for invite in currentInvites {
                    FirebaseTeams.instance.loadTeamName(forTeamCode: invite) { (name, teamcode) in
                        names.updateValue(teamcode, forKey: name)
                        if names.count == currentInvites.count {
                            completion(names)
                        }
                    }
                }
            }
        }
    }
    
    func removeTeamFromInviteList(forTeam teamCode : String, forUsername username : String, completion : @escaping (Bool) -> ()) {
        let keys = FirebaseKeys()
        FirebaseCore.instance.readInformation(collection: keys.userNameInformationKey, document: username) { (information) in
            if let information = information {
                var currentInvites = information["Team_Invites"] as? [String] ?? []
                if let index = currentInvites.firstIndex(of: teamCode) {
                    currentInvites.remove(at: index)
                } else {
                    completion(false)
                }
                FirebaseCore.instance.updateWithTransaction(collection: keys.userNameInformationKey, document: username, information: ["Team_Invites" : currentInvites]) { (success) in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func addTeamToCurrentTeamsList(forTeam teamCode : String, forUsername username : String, completion : @escaping (Bool) -> ()) {
        let keys = FirebaseKeys()
        FirebaseCore.instance.readInformation(collection: keys.userNameInformationKey, document: username) { (information) in
            if let information = information {
                var currentTeams = information["Current_Teams"] as? [String] ?? []
                if !currentTeams.contains(teamCode) {
                    currentTeams.append(teamCode)
                    FirebaseCore.instance.updateWithTransaction(collection: keys.userNameInformationKey, document: username, information: ["Current_Teams" : currentTeams]) { (success) in
                        if success {
                            FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
                                if let information = information {
                                    var currentUsers = information[keys.teamUsersKey] as? [String] ?? []
                                    currentUsers.append(UserManager.getUserManager().getUser().uid)
                                    FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: [keys.teamUsersKey : currentUsers]) { (success) in
                                        completion(success)
                                    }
                                } else {
                                    FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: teamCode, information: [keys.teamUsersKey : [UserManager.getUserManager().getUser().uid]]) { (success) in
                                        completion(success)
                                    }
                                }
                            }
                        }
                        completion(success)
                    }
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func changeUsername(currentUsername cUser : String, newUsername nUser : String, completion : @escaping (Bool) -> ()) {
        let keys = FirebaseKeys()
        setUsername(withUID: UserManager.getUserManager().getUser().uid, username: nUser) { (success) in
            if success {
                FirebaseCore.instance.readInformation(collection: keys.userNameInformationKey, document: cUser) { (information) in
                    if let information = information {
                        FirebaseCore.instance.updateWithTransaction(collection: keys.userNameInformationKey, document: nUser, information: information) { (success) in
                            Firestore.firestore().collection(keys.userNameInformationKey).document(cUser).delete { (error) in
                                if let error = error {
                                    print(error.localizedDescription)
                                }
                                completion(true)
                            }
                        }
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
}
