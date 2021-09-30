//
//  LoginInspector.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


class LoginInspector: LoginViewControllerDelegate {
    func checkTextFields(login: String, password: String) -> Bool {
        
        let checker = Checker.instance.checkLoginData(enteredLogin: login, enteredPassword: password)
        return checker
    }
    
    
}
