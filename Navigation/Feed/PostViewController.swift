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
    
    var showInfo: (()-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action:  #selector(tapInfoButton))
        view.backgroundColor = .systemPink
    }
    
    @objc func tapInfoButton () {

        self.showInfo?()

    }
}
