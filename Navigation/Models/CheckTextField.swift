//
//  CheckTextField.swift
//  Navigation
//
//  Created by Maria Mezhova on 11.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//


import UIKit

enum CheckerError: Error {
    case incorrect
    case empty
}

class CheckTextField {
    
    private let correctWord = "пароль"
    
    
    // method 1 - passing data via notifications
    
    //    func check(word: String) {
    //
    //        if word != "" {
    //            if word == correctWord {
    //                NotificationCenter.default.post(name: NSNotification.Name("Green label"), object: nil)
    //            } else {
    //                NotificationCenter.default.post(name: NSNotification.Name("Red label"), object: nil)
    //            }
    //        } else {
    //            NotificationCenter.default.post(name: NSNotification.Name("Transparent label"), object: nil)
    //        }
    //    }
    
    // method 2 - passing data via callback closure
    
    func check(word: String, completion:  @escaping (Result<String, CheckerError>) -> Void  ) {
        if word == correctWord {
            completion(.success("Correct!"))
        } else if word == "" {
            completion(.failure(.empty))
        } else {
            completion(.failure(.incorrect))
        }
    }
}

