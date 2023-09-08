//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var timer = Timer()
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        var totalTime = 0
        var secondsPassed = 0
        timer.invalidate()
        self.titleLabel.text = "How do you like your eggs?"
        let hardness = sender.currentTitle!
        totalTime = self.eggTimes[hardness]!
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if secondsPassed < totalTime {
                
                
                secondsPassed += 1
                
                let percentageProgress = Float(secondsPassed)/Float(totalTime)
                
                self.progressBar.progress = percentageProgress
                
             } else {
                 Timer.invalidate()
                 
                
                 
                 self.titleLabel.text = "DONE "
                 
             }
         }
        
    }
    
    
    

    

}
