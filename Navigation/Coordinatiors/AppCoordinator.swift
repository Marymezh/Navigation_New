//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
//    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    let window: UIWindow?

    private var firstViewController: UIViewController!
    private var secondViewController: UIViewController!

    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func start() {
        let tabBarController = self.setTabBarController()
        self.window?.rootViewController = tabBarController
    }

    func setTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let firstItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        let secondItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)


        let firstViewCoordinator = FirstViewCoordinator()
        firstViewCoordinator.parentCoordinator = self
        childCoordinator.append(firstViewCoordinator)
        let firstViewController = firstViewCoordinator.startPush()
        firstViewController.tabBarItem = firstItem

        let secondViewCoordinator = SecondViewCoordinator()
        secondViewCoordinator.parentCoordinator = self
        childCoordinator.append(secondViewCoordinator)
        let secondViewController = secondViewCoordinator.startPush()
        secondViewController.tabBarItem = secondItem

        tabBarController.viewControllers = [firstViewController, secondViewController]

        return tabBarController
    }
}

