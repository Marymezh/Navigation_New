//
//  SecondViewCoordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    var inspectorFactory = MyLoginFactory()
    var moduleFactory = ProfileModuleFactory()
    
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let loginVC = LogInViewController()
        
        #if DEBUG
        loginVC.loginFactory = inspectorFactory
        loginVC.pushProfile = { [weak self] userService, username in
            self?.showProfileVC(userService: userService, username: username)
        }
        #else
        loginVC.pushProfile = { [weak self] in
            self?.showProfileVC()
        }
        #endif
        
        navigationController.setViewControllers([loginVC], animated: false)
        
        return navigationController
    }
    
}

extension ProfileCoordinator {
    
    #if DEBUG
   
    func showProfileVC(userService: UserService, username: String) {
        
        let profileVC = moduleFactory.produceProfileVC(userService: userService, userName: username)
        navigationController.pushViewController(profileVC, animated: true)
        
        profileVC.viewModel.pushPhotos = { [weak self] in
            self?.showPhotosVC()
        }
        
        profileVC.viewModel.presentAudioPlayer = { [weak self] in
            self?.presentAudioPlayerVC()
        }
        
        profileVC.viewModel.pushVideoPlayer = { [weak self] in
            self?.showVideoPlayerVC()
        }
    }
    
    #else
    func showProfileVC() {
        
        let profileVC = moduleFactory.produceProfileVC()
        navigationController.pushViewController(profileVC, animated: true)
        
        profileVC.viewModel.pushPhotos = { [weak self] in
            self?.showPhotosVC()
        }
        
        profileVC.viewModel.presentAudioPlayer = { [weak self] in
            self?.presentAudioPlayerVC()
        }
        
        profileVC.viewModel.pushVideoPlayer = { [weak self] in
            self?.showVideoPlayerVC()
        }
        
        profileVC.viewModel.profileHeaderView.logoutHandler = { [weak self] in
            self?.logout()
        }
    }
    #endif
    
    
    func showPhotosVC() {
        let photosVC = PhotosViewController()
        navigationController.pushViewController(photosVC, animated: true)
    }
    
    func presentAudioPlayerVC() {
        let audioPlayerVC = AudioPlayerViewController()
        navigationController.present(audioPlayerVC, animated: true, completion: nil)
        
    }
    
    func showVideoPlayerVC() {
        let videoPlayerVC = VideoViewController()
        navigationController.pushViewController(videoPlayerVC, animated: true)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            navigationController.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
    }
}
