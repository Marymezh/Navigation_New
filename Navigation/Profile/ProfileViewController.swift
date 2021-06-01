//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private(set) lazy var newButton: UIButton = {
        let newButton = UIButton()
        newButton.setTitle("NEW BUTTON", for: .normal)
        return newButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        configureButton()
    }
    
    private func configureButton() {
        self.view.addSubview(newButton)
        newButton.setTitle("NEW BUTTON", for: .normal)
        newButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        newButton.setTitleColor(.white, for: .normal)
        newButton.layer.backgroundColor = UIColor.blue.cgColor
        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        let newbuttonConstraints = [
            newButton.heightAnchor.constraint(equalToConstant: 50),
            newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(newbuttonConstraints)
        
    }
}

