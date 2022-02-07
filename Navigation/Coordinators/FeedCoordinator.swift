//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    let checker = CheckTextField()

    func start() {
    }

    func startPush() -> UINavigationController {
        let feedVC = FeedViewController(checker: checker)
        
        navigationController.setViewControllers([feedVC], animated: false)

        feedVC.showPost = { [weak self] in
            self?.showPostNormally()
        }
        
        feedVC.presentPost = { [weak self] in
            self?.showPostModally()
        }
        
        return navigationController
    }
}

extension FeedCoordinator {
    func showPostNormally()  {
        let postVC = PostViewController()
        navigationController.pushViewController(postVC, animated: true)
        
        postVC.showInfo = { [weak self] in
            self?.showInfoVC()
        }
    }
    
    func showPostModally()  {
        let postVC = PostViewController()
        navigationController.present(postVC, animated: true, completion: nil)
    }
    
    func showInfoVC() {
        let infoVC = InfoViewController()
        navigationController.pushViewController(infoVC, animated: true)
    }
}

