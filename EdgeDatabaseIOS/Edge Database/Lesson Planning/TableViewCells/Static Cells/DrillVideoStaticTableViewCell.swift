//
//  DrillVideoStaticTableViewCell.swift
//  Lessons Pro
//
//  Created by Benjamin Hilger on 1/13/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import UIKit
import AVFoundation
import SharedCode

class DrillVideoStaticTableViewCell: UITableViewCell {
    // Controls the video label
    @IBOutlet var drillVideoLabel : UIButton!
    // Delegate for the video
    var delegate : DrillVideoDelegate?

    
    func setupCell(forDelegate d : DrillVideoDelegate, forDrill drill : Drill) {
        // Sets the delegate
        delegate = d
        // Sets the title based on if there's a video or not
        drillVideoLabel.setTitle(drill.videoURL != nil ? "Click to View Video" : "No Video Selected", for: .normal)
    }
    
    @IBAction func selectVideo() {
        // Calls the delegate to start video selection
        delegate?.startVideoSelection()
    }
    
}

protocol DrillVideoDelegate {
    func startVideoSelection()

}
