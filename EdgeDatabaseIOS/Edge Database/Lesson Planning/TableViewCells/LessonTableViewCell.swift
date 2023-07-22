//
//  LessonTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/5/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class LessonTableViewCell : UITableViewCell {
    
    @IBOutlet var lessonName : UILabel!
    @IBOutlet var numOfLessons : UILabel!
    
    func setupCell(forLesson l : Lesson) {
        lessonName.text = l.lessonName
        numOfLessons.text = "\(l.drills.count)"
    }
}
