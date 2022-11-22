//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by David Terwilliger on 11/21/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation


struct Question {
    let text: String
    let answer: String
    
    init(q: String,a: String) {
        self.text = q
        self.answer = a
        
    }
    
}
