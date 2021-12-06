//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
    
//    weak var coordinator: FeedCoordinator?
    
    var showInfo: (()-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action:  #selector(tapInfoButton))
        view.backgroundColor = .systemPink
    }
    
    @objc func tapInfoButton () {
// navigate to another screen using weak link to coordinator
//        coordinator?.showInfoVC()
        self.showInfo?()

    }
}
