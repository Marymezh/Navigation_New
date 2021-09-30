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
        
        loginVC.coordinator = self
        loginVC.loginFactory = inspectorFactory
        navigationController.setViewControllers([loginVC], animated: false)
        
        return navigationController
    }
    
}

extension ProfileCoordinator {
    func showProfileVC()  {
       
    }
}
