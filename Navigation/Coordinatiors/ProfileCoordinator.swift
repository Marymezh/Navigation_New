//
//  SecondViewCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    var inspectorFactory = MyLoginFactory()
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let loginVC = LogInViewController()
        
//        loginVC.coordinator = self
        loginVC.loginFactory = inspectorFactory
        
        loginVC.pushProfile = { [weak self] userService, username in
            self?.showProfileVC(userService: userService, username: username)
        }
        
        navigationController.setViewControllers([loginVC], animated: false)
        
        return navigationController
    }
    
}

extension ProfileCoordinator {
    func showProfileVC(userService: UserService, username: String) {
        let profileVC = ProfileViewController(userService: userService, userName: username, coordinator: self)
        navigationController.pushViewController(profileVC, animated: true)
       
        profileVC.pushPhotos = { [weak self] in
            self?.showPhotosVC()
        }
    }
    
    func showPhotosVC() {
        let photosVC = PhotosViewController(coordinator: self)
        navigationController.pushViewController(photosVC, animated: true)
    }
}
