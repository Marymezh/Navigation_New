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
    
    weak var coordinator: FeedCoordinator?
    
 //   var showInfo: (()-> Void)?
    
    init(coordinator: FeedCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action:  #selector(tapInfoButton))
        view.backgroundColor = .systemPink
    }
    
    @objc func tapInfoButton () {
        coordinator?.showInfoVC()
   //     self.showInfo?()

    }
}
