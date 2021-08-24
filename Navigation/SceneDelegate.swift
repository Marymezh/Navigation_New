//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // ДЗ 4.1 - инициализируем инспектора
    
//    var inspector = LoginInspector()
    
    // ДЗ 4.2 - инициализируем фабрику
    
    var inspectorFactory = MyLoginFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // ДЗ 4.1
//        if let tabController = window?.rootViewController as? UITabBarController, let loginNavigation = tabController.viewControllers?.last as? UINavigationController, let loginController = loginNavigation.viewControllers.first as? LogInViewController {
//            loginController.delegate = inspector
        
        
        // ДЗ 4.2
        if let tabController = window?.rootViewController as? UITabBarController, let loginNavigation = tabController.viewControllers?.last as? UINavigationController, let loginController = loginNavigation.viewControllers.first as? LogInViewController {
            loginController.loginFactory = inspectorFactory
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
}

