//
//  UserService.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol UserService {
    
    func returnUser (userName: String) throws -> User
    
}
