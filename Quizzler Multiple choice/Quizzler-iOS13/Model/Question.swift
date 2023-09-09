//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Arya on 08/09/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text : String
    let options : [String]
    let correctAnswer : String
    
    init(q:String, a: [String], correctAnswer: String) {
        self.text = q
        self.options = a
        self.correctAnswer = correctAnswer
        
    }
}
