//
//  ProfileModuleFactoryProtocol.swift
//  Navigation
//
//  Created by Maria Mezhova on 17.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileModuleFactoryProtocol {
    
    func produceProfileVC(userService: UserService, userName: String) -> ProfileViewController
    
    func produceProfileViewModel() -> ProfileViewModel
}
