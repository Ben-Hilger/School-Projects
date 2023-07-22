//
//  FirebaseTeams.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 5/31/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode
import Firebase

class FirebaseTeams {
    
    let database = Firestore.firestore()
    
    func generateTeamCode() -> String {
        let keys = FirebaseKeys()
        return database.collection(keys.teamInformationKey).document().documentID
    }
    
    func loadTeam(teamCode : String, completion : @escaping (Team?) -> ()) {
        FirebaseDrills.instance.loadDrills(forTeam: teamCode) { (drills) in
                DrillManager.getDrillManager().drills = drills ?? []
                FirebaseLesson.instance.loadLessons(forTeam: teamCode) { (lessons) in
                    LessonManager.getLessonManager().lessonPlans = lessons ?? []
                    let keys = FirebaseKeys()
                    print(teamCode)
                    FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
                        if let information = information {
                            let name = information[keys.teamNameKey] as? String ?? ""
                            let users = information[keys.teamUsersKey] as? [String] ?? []
                            let owner = information[keys.teamOwnerKey] as? String ?? ""
                            let email = information[keys.teamEmailKey] as? String ?? ""
                            let location = information[keys.teamLocationKey] as? String ?? ""
                            let website = information[keys.teamWebsiteKey] as? String ?? ""
                            let team = Team(tC: teamCode, n: name)
                            
                            team.owner = owner
                            team.email = email
                            team.location = location
                            team.website = website
                            if users.count == 0 {
                                completion(team)
                            } else {
                                for user in users {
                                    FirebaseUser.getFirebaseAccount().loadUser(withUID: user) { (loadedUser) in
                                        if let loadedUser = loadedUser {
                                            team.addUser(user: loadedUser)
                                        }
                                        if team.users.count == users.count {
                                            completion(team)
                                        }
                                    }
                                }
                            }
                        } else {
                            completion(nil)
                        }
                    }
                }
        }
    }
    
    func saveTeamInfo(team : Team, completion : @escaping (Bool) -> ()) {
        let keys = FirebaseKeys()
        var users : [String] = []
        for user in team.users {
            if let user = user as? SharedCode.User {
                users.append(user.uid)
            }
        }
        FirebaseCore.instance.updateWithTransaction(collection: keys.teamInformationKey, document: team.teamCode, information: [keys.teamNameKey : team.name,
                                                                                                                                keys.teamUsersKey : users,
                                                                                                                                keys.teamOwnerKey : team.owner ?? "",
                                                                                                                                keys.teamEmailKey : team.email ?? "",
                                                                                                                                keys.teamLocationKey : team.location ?? "",
                                                                                                                                keys.teamWebsiteKey : team.website ?? ""]) { (success) in
            completion(success)
        }
    }
    
    func loadTeamName(forTeamCode teamCode : String, completion : @escaping (String, String) -> ()) {
        let keys = FirebaseKeys()
        FirebaseCore.instance.readInformation(collection: keys.teamInformationKey, document: teamCode) { (information) in
            if let information = information {
                completion(information[keys.teamNameKey] as? String ?? "", teamCode)
            }
        }
    }
    
    
    static let instance = FirebaseTeams()
    
}
