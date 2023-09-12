//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()

    @IBOutlet weak var billTextField: UITextField!
 
    @IBOutlet weak var zeroPctButton: UIButton!
    
    @IBOutlet weak var tenPctButton: UIButton!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        calculatorBrain.split.percentageSelected = sender.currentTitle
        
        calculatorBrain.tipCalculator(zeroBut : zeroPctButton, tenBut : tenPctButton, twentyBut : twentyPctButton, compare: sender )
        
       
    }
    
    @IBAction func steppedValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = calculatorBrain.getStepperString(value: sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVc = segue.destination as! ResultsViewController
            destinationVc.totalValue = calculatorBrain.calculation(billField: billTextField, splitNumberField: splitNumberLabel)
            destinationVc.numberPeople = splitNumberLabel.text
            destinationVc.percentage = calculatorBrain.split.percentageSelected
            
            
        }
    }
    

}

