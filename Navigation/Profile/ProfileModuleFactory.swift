//
//  ProfileModuleFactory.swift
//  Navigation
//
//  Created by Maria Mezhova on 01.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class ProfileModuleFactory{
    #if DEBUG
    func produceProfileVC(userService: UserService, userName: String) -> ProfileViewController {
        return ProfileViewController(userService: userService, userName: userName)
    }
    #else
    func produceProfileVC() -> ProfileViewController {
        return ProfileViewController()
    }
    #endif
    
    
    func produceProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel()
    }
}
