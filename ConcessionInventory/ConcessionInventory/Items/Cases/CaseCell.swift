//
//  CaseCell.swift
//  ConcessionInventory
//
//  Created by Ben Hilger on 8/19/18.
//  Copyright © 2018 Ben Hilger. All rights reserved.
//

import Foundation
import UIKit

class CaseCell : UITableViewCell {
    
    @IBOutlet var name : UILabel!
    @IBOutlet var amtPerCase : UILabel!
    @IBOutlet var amt : UILabel!
    @IBOutlet var stepper : UIStepper!
    
    private var caseC : CaseCounter? = nil
    
    private var funcToRun : () -> Void? = {
        () -> Void in
        
    }
    
    func addCaseCounter(cc : CaseCounter, functoRun : @escaping () -> Void){
        caseC = cc
        name.text = cc.getName()
        amtPerCase.text = String(cc.getAmountPerCase()) + "/Case"
        amt.text = String(cc.getAmountOfCases())
        self.funcToRun = functoRun
    }
    
    @IBAction func valueChanged(sender : UIStepper){
        amt.text = String(sender.value)
        caseC?.setAmount(a: Int(sender.value))
        funcToRun()
    }

    
    
    
}
