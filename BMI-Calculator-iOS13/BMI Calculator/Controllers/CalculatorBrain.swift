//
//  CalculatorBrain.swift
//  BMI Calculator
//  Created by Arya on 11/09/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    
    var bmi : Float?
    
    func getBmiValue() -> String{
        
        let bmiValue = String(format: "%.1f", bmi ?? "0.0") //Nil Coalescing Operator
        
        return bmiValue
        
    }
    
    mutating func calculateBmi(height: Float, weight : Float){
        bmi = weight/(height * height)
        
    }
}
