//
//  ProfileModuleFactory.swift
//  Navigation
//
//  Created by Maria Mezhova on 01.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation


class ProfileModuleFactory: ProfileModuleFactoryProtocol {
    func produceProfileVC(userService: UserService, userName: String) -> ProfileViewController {
        return ProfileViewController(userService: userService, userName: userName)
    }
    
    func produceProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel()
    }
}
