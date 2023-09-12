//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Arya on 12/09/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

struct CalculatorBrain{
    
    var split = SplitData()
    
    mutating func tipCalculator(zeroBut : UIButton, tenBut : UIButton, twentyBut : UIButton, compare: UIButton){
        if compare == zeroBut {
            zeroBut.isSelected = true
            tenBut.isSelected = false
            twentyBut.isSelected = false
            split.tipPercentage = 0.0
            
        }
        
        else if compare == tenBut {
            zeroBut.isSelected = false
            tenBut.isSelected = true
            twentyBut.isSelected = false
            split.tipPercentage = 0.1
        }
        
        else {
            zeroBut.isSelected = false
            tenBut.isSelected = false
            twentyBut.isSelected = true
            split.tipPercentage = 0.2
        }
        
    }
    
    func getStepperString(value: Double?) -> String {
        return String(format: "%.0f", value ?? 1.0)
    }
    
    func calculation(billField: UITextField, splitNumberField : UILabel) -> String {
        let inputBill = billField.text ?? "None"
        let inputValue = Float(inputBill)
        let splitNumber = Float(splitNumberField.text ?? "1.0")
        let oneValue = 1 + (split.tipPercentage ?? 1.0)
        let calculatedShare = Double(Float(oneValue) * inputValue! / splitNumber!)
        let calculatedValue = String(format:"%.2f", calculatedShare)
        billField.endEditing(true)
        
        return calculatedValue
    }
    
    
}
