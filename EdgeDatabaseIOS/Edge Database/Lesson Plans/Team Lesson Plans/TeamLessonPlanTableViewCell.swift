//
//  TeamLessonPlanTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 6/18/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class TeamLessonPlanTableViewCell : UITableViewCell {
    // Outlet that controls the label seen in the cell by the user on the view
    @IBOutlet var lessonTitle : UILabel!
    
    func configureCell(forLesson lesson : Lesson) {
        // Sets the text of the label to the lesson name
        lessonTitle.text = lesson.lessonName
    }
}
