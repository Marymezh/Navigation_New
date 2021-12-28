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

