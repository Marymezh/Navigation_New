//
//  LoginFactory.swift
//  Navigation
//
//  Created by Maria Mezhova on 24.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol LoginFactory {
    
    func produceLoginInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    func produceLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
    
    
}
