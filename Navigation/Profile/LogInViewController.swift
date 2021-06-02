//
//  LogInViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 01.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let logoVKImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.toAutoLayout()
        return imageView
    }()
    
    private let autorizationView: UIView = {
        let autorizationView = UIView()
        autorizationView.backgroundColor = .lightGray
        autorizationView.layer.borderWidth = 0.5
        autorizationView.layer.borderColor = UIColor.lightGray.cgColor
        autorizationView.layer.cornerRadius = 10
        autorizationView.clipsToBounds = true
        autorizationView.toAutoLayout()
        return autorizationView
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField .frame.height))
        textField.leftViewMode = .always
        textField.tintColor = UIColor(named:"myColorSet")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.clipsToBounds = true
        textField.placeholder = "Email or Phone"
        textField.toAutoLayout()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField .frame.height))
        textField.leftViewMode = .always
        textField.tintColor = UIColor(named:"myColorSet")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.clipsToBounds = true
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.toAutoLayout()
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        
        if button.isSelected {
            button.alpha = 0.8
        } else if button.isHighlighted {
            button.alpha = 0.8
        } else if button.isEnabled == false {
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }
    
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        //button.addTarget(self, action: #selector(tapLogInButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(logoVKImageView)
        view.addSubview(autorizationView)
        autorizationView.addSubview(emailTextField)
        autorizationView.addSubview(passwordTextField)
        view.addSubview(logInButton)
        let constraints = [
            logoVKImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoVKImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoVKImageView.widthAnchor.constraint(equalToConstant: 100),
            logoVKImageView.heightAnchor.constraint(equalToConstant: 100),
            
            autorizationView.topAnchor.constraint(equalTo: logoVKImageView.bottomAnchor, constant: 120),
            autorizationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            autorizationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            autorizationView.heightAnchor.constraint(equalToConstant: 100),
            
            emailTextField.topAnchor.constraint(equalTo: autorizationView.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: autorizationView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: autorizationView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 49.7),
            
            passwordTextField.bottomAnchor.constraint(equalTo: autorizationView.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: autorizationView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: autorizationView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 49.7),
            
            logInButton.topAnchor.constraint(equalTo: autorizationView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
  }
}
    
    extension UIView {
        func toAutoLayout() {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
}

