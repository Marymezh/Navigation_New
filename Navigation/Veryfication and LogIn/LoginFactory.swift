//
//  LoginFactory.swift
//  Navigation
//
//  Created by Maria Mezhova on 24.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

// ДЗ 4.2 - создаем протокол и фабрику для производства логин инспектора

protocol LoginFactory {
    func produceLoginInspector() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    func produceLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
