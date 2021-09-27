//
//  FirstViewCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class FirstViewCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    let checker = CheckTextField()

    init() {
        self.navigationController = .init()
    }

    func start() {
    }

    func startPush() -> UINavigationController {
        let firstViewController = FeedViewController(checker: checker)
        firstViewController.coordinator = self
        navigationController.setViewControllers([firstViewController], animated: false)

        return navigationController
    }
}
