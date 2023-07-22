//
//  CenterTextAreaTableViewCell.swift
//  Edge Database
//
//  Created by Benjamin Hilger on 3/26/20.
//  Copyright © 2020 Benjamin Hilger. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class CenterTextAreaTableViewCell : UITableViewCell, UITextViewDelegate {

    @IBOutlet var textArea : UITextView!
    
    var commentViewing : Comments?
    
    var delegate : CenterTextAreaDelegate?
    
    func configureCell(withContent con : String, forComment c : Comments) {
        textArea.text = con
        textArea.delegate = self
        commentViewing = c
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        commentViewing?.content = textView.text
        delegate?.updated()
    }

    
}

protocol CenterTextAreaDelegate {
    
    func updated()
}
