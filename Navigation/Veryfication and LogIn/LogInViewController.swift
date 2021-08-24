//
//  LogInViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 01.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    // ДЗ 4.1 
//    weak var delegate: LoginViewControllerDelegate?
    
    
    // ДЗ 4.2
    var loginFactory: MyLoginFactory?
    
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
        textField.placeholder = "User Name"
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
        button.addTarget(self, action: #selector(tapLogInButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private func showAlert() {
        let alertController = UIAlertController(title: "ERROR", message: "User name or password is invalid", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Chancel", style: .default) { _ in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        print("invalid name")
    }
    
    @objc private func tapLogInButton() {
        // ДЗ 3
        // изменяем способ показа экрана ProfileVC, теперь чтобы туда попасть надо ввести имя пользователя, который хранится в экземпляре UserService
        // если имя введено неверно, появляется ошибка
        // разные юзеры для Дебаг и Релиз схем
        
        #if DEBUG
        let userService = TestUserService()
        #else
        let userService = CurrentUserService()
        #endif
        
//        ДЗ 4.1 - проверяем логин и пароль через делегата
        
//        if  let username = usernameTextField.text,
//            delegate?.checkTextFields(enteredLogin: username, enteredPassword: passwordTextField.text ?? "") == true {
//            let profileVC = ProfileViewController(userService: userService, userName: username )
//            navigationController?.pushViewController(profileVC, animated: true)
//        } else {
//            showAlert()
//        }
        
        
       // ДЗ 4.2 - создаем испектора через фабричный метод и проверяем логин и пароль
      
        if let username = usernameTextField.text,
        let inspector = loginFactory?.produceLoginInspector,
        inspector().checkTextFields(enteredLogin: username, enteredPassword: passwordTextField.text ?? "") == true {
            let profileVC = ProfileViewController(userService: userService, userName: username )
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            showAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

