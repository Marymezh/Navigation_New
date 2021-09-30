//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    let window: UIWindow?


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


        let feedCoordinator = FeedCoordinator()
        feedCoordinator.parentCoordinator = self
        childCoordinator.append(feedCoordinator)
        let feedVC = feedCoordinator.startPush()
        feedVC.tabBarItem = firstItem

        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.parentCoordinator = self
        childCoordinator.append(profileCoordinator)
        let profileVC = profileCoordinator.startPush()
        profileVC.tabBarItem = secondItem

        tabBarController.viewControllers = [feedVC, profileVC]

        return tabBarController
    }
}

