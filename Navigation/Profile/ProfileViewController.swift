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
        
        self.view.addSubview(newButton)
            newButton.setTitle("NEW BUTTON", for: .normal)
            newButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            newButton.setTitleColor(.white, for: .normal)
            newButton.layer.backgroundColor = UIColor.blue.cgColor
            newButton.layer.cornerRadius = 14
            newButton.layer.shadowColor = UIColor.black.cgColor
            newButton.layer.shadowOffset = CGSize(width: 4, height: 4)
            newButton.layer.shadowOpacity = 0.7
            newButton.translatesAutoresizingMaskIntoConstraints = false
            newButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            newButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +16).isActive = true
            newButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

}
