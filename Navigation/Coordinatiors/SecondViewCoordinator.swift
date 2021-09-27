//
//  SecondViewCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class SecondViewCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    var inspectorFactory = MyLoginFactory()
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let secondViewController = LogInViewController()
        
        secondViewController.coordinator = self
        secondViewController.loginFactory = inspectorFactory
        navigationController.setViewControllers([secondViewController], animated: false)
        
        return navigationController
    }
    
}
