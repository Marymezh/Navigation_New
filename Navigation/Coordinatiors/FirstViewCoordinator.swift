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
    
    weak var parentCoordinator: AppCoordinator?
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
     
   
     //   firstViewController.coordinator = self
        navigationController.setViewControllers([firstViewController], animated: false)

        firstViewController.showPost = { [weak self] in
            self?.showPostNormally()
        }
        
        firstViewController.presentPost = { [weak self] in
            self?.showPostModally()
        }
        
//        postViewController.showInfo = {[weak self] in
//            self?.showInfoVC()
//        }
        
        return navigationController
    }
}

extension FirstViewCoordinator {
    func showPostNormally() {
        let vc = PostViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showPostModally() {
        let vc = PostViewController()
        self.navigationController.present(vc, animated: true, completion: nil)
    }
    
//    func showInfoVC() {
//        let vc = InfoViewController()
//        self.navigationController.pushViewController(vc, animated: true)
//    }
}

