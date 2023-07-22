//
//  SportSelectionDelegate.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 10/28/19.
//  Copyright © 2019 Benjamin Hilger. All rights reserved.
//

import Foundation

protocol SportSelectionDelegate {
    func sportSelected(sport : [String])
    func cancel()
}
