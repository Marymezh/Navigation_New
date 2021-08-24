//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Maria Mezhova on 19.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func checkTextFields(enteredLogin: String, enteredPassword: String) -> Bool
}
