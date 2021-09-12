//
//  CheckTextField.swift
//  Navigation
//
//  Created by Maria Mezhova on 11.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class CheckTextField {
    
    
    private let correctWord: String
    
    init(correctWord: String) {
        self.correctWord = correctWord
    }
    
    func check(word: String) {
        
        if word  == correctWord {
            NotificationCenter.default.post(name: NSNotification.Name("Green label"), object: nil)
        } else  if word == "" {
            NotificationCenter.default.post(name: NSNotification.Name("Transparent label"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("Red label"), object: nil)
        }
}
}
