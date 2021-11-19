//
//  Checker.swift
//  Navigation
//
//  Created by Maria Mezhova on 19.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class Checker {
    
    
    static var instance = Checker()
    #if DEBUG
    private let login = "Test"
    #else
    private let login = "Anonim"
    #endif
    
    
    private let password = "pass"
    
    private init() {}
    
    func checkLoginData(enteredLogin: String, enteredPassword: String) -> Bool {
        if enteredLogin == login && enteredPassword == password {
            return true
        } else {
            return false
        }
        
    }
}
