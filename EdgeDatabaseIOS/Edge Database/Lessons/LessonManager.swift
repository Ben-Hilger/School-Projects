//
//  LessonManager.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/4/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import SharedCode

class LessonManager {
    var lessonPlans : [Lesson] = []
    
    func getLessonPresets() -> [Lesson] {
        return lessonPlans
    }
    
    func addLesson(withName : String) -> Lesson {
        // Explores the current lesson plans
        for i in 0..<lessonPlans.count {
            // Examines the current lesson
            let lesson = lessonPlans[i]
            // Checks to see if this lesson has the same name
            if lesson.lessonName.elementsEqual(withName) {
                // Returns nil to the callback to represent a lesson with
                // that name already exists
                return lesson
            }
        }
        // Creates the new lesson
        let newLesson = Lesson(n: withName)
        // Sets the lesson number for saving
        newLesson.lessonNumber = KotlinInt(integerLiteral: lessonPlans.count)
        // Adds the new lesson to the lesson plans
        lessonPlans.append(newLesson)
        // Returns the new lesson plans to the callback
        return newLesson
    }
        
    
    
    func saveLesson(lesson : Lesson, completion : @escaping (Bool) -> Void) {
        // Checks to ensure there's a current team being edited
        if let team = TeamManager.instance.teamEditing {
            // Attempts to save the specified lesson to Firebase
            FirebaseLesson.instance.saveLesson(lessonToSave: lesson, lesson_number: Int(truncating: lesson.lessonNumber ?? KotlinInt(integerLiteral: lessonPlans.count)), forTeam: team.teamCode) { (success) in
                // Returns the success through the callback
                completion(success)
            }

        }
    }
    
    func loadLessons(completion : @escaping (Bool) -> Void) {
        // Checks to ensure there's a current team being edited
        if let team = TeamManager.instance.teamEditing {
            // Attempts to load the lessons from Firebase
            FirebaseLesson.instance.loadLessons(forTeam: team.teamCode) { (lessons) in
                // Checks to see if the lessons where successfully loaded
                if let lessons = lessons {
                    // Sets the lesson plans to the ones downloaded
                    self.lessonPlans = lessons
                    // Returns true to represent a successful download from Firebase
                    completion(true)
                } else {
                    // Returns false to represent a failed download from Firebase
                    completion(false)
                }
            }
        }
    }
    
    private static let lessonMan : LessonManager = LessonManager()
    
    static func getLessonManager() -> LessonManager {
        return lessonMan
    }
}
