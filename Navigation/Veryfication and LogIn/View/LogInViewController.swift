//
//  LogInViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 01.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Firebase

enum AuthorizationError: Error {
    case empty
    case incorrect
}

class LogInViewController: UIViewController {
    
    var loginFactory: MyLoginFactory?
    
    #if DEBUG
    var pushProfile: ((_ userService: UserService, _ username: String) -> Void)?
    #else
    var pushProfile: (()-> Void)?
    #endif
    
    private let scrollView = UIScrollView()
    
    private let logInView: UIView = {
        let logInView = UIView()
        logInView.backgroundColor = .white
        logInView.toAutoLayout()
        return logInView
    }()
    
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
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField .frame.height))
        textField.leftViewMode = .always
        textField.tintColor = UIColor(named:"myColorSet")
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.clipsToBounds = true
        #if DEBUG
        textField.placeholder = "User Name"
        #else
        textField.placeholder = "Email"
        #endif
        textField.returnKeyType = UIReturnKeyType.done
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
        textField.returnKeyType = UIReturnKeyType.done
        textField.toAutoLayout()
        return textField
    }()
    
    private lazy var logInButton: MyCustomButton = {
        let button = MyCustomButton(title: "Log in", titleColor: .white, backgroundColor: nil, backgroundImage: #imageLiteral(resourceName: "blue_pixel")) { [weak self] in
            guard let self = self else { return }
            do {
                try self.performLogin()
            } catch AuthorizationError.empty {
                self.showAlert(message: "Do not live blank fields!")
            } catch AuthorizationError.incorrect {
                self.showAlert(message: "User name or password is invalid")
            } catch {
                self.showAlert(message: "Unexpected error")
            }
        }
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private func performLogin() throws {
        
        #if DEBUG
        let userService = TestUserService()
 //       let userService = CurrentUserService()
        guard usernameTextField.text != "" || passwordTextField.text != "" else {
            throw AuthorizationError.empty
        }
        guard let username = usernameTextField.text,
              let pswd = passwordTextField.text,
              let inspector = loginFactory?.produceLoginInspector,
              inspector().checkTextFields(login: username, password: pswd) == true else {
            throw AuthorizationError.incorrect
        }
        pushProfile?(userService, username)
        
        #else
        guard usernameTextField.text != "" || passwordTextField.text != "" else {
            throw AuthorizationError.empty
        }
        if let email = usernameTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    self.showNewUserAlert(error: error, email: email, password: password)
                } else {
                    self.pushProfile?()
                }
            }
        }
        #endif
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showNewUserAlert(error: Error, email: String, password: String) {
        let alertController = UIAlertController(title: "WARNING", message: "The user does not exist! Want to try again or create a new user?", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "RETRY", style: .destructive, handler: nil)
        alertController.addAction(retryAction)
        let createAction = UIAlertAction(title: "CREATE NEW USER", style: .default) { _ in
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                if let error = error {
                    self.showAlert(message: "Failed to create new user \(error.localizedDescription)")
                } else {
                    self.pushProfile?()
                }
            }
        }
        alertController.addAction(createAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupViews()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupViews() {
        
        scrollView.toAutoLayout()
        
        view.addSubview(scrollView)
        scrollView.addSubview(logInView)
        logInView.addSubviews(logoVKImageView, autorizationView, logInButton)
        autorizationView.addSubviews(usernameTextField, passwordTextField)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logInView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            logInView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            logInView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            logInView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoVKImageView.topAnchor.constraint(equalTo: logInView.topAnchor, constant: 120),
            logoVKImageView.centerXAnchor.constraint(equalTo: logInView.centerXAnchor),
            logoVKImageView.widthAnchor.constraint(equalToConstant: 100),
            logoVKImageView.heightAnchor.constraint(equalToConstant: 100),
            
            autorizationView.topAnchor.constraint(equalTo: logoVKImageView.bottomAnchor, constant: 120),
            autorizationView.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            autorizationView.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            autorizationView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameTextField.topAnchor.constraint(equalTo: autorizationView.topAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: autorizationView.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: autorizationView.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 49.7),
            
            passwordTextField.bottomAnchor.constraint(equalTo: autorizationView.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: autorizationView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: autorizationView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 49.7),
            
            logInButton.topAnchor.constraint(equalTo: autorizationView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: logInView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: logInView.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: logInView.bottomAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

