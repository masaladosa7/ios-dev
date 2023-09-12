//
//  CalculatorBrain.swift
//  BMI Calculator
//  Created by Arya on 11/09/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain{
    
    var bmi : BMI?
    
    func getBmiValue() -> String{
        
        let bmiValue = String(format: "%.1f", bmi?.value ?? "0.0") //Nil Coalescing Operator and Optional Chaining
        
        return bmiValue
        
    }
    
    mutating func calculateBmi(height: Float, weight : Float){
        let bmiValue = weight/(height * height)
        
        if bmiValue<18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: .systemBrown)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: .systemTeal)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: .systemPink)
        }
        
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "None"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
}
