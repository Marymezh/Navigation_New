//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit


final class FeedViewController: UIViewController {
    
    let checker = CheckTextField(correctWord: "пароль")
    
    private lazy var showNormallyButton: UIButton = {
        let button =
            MyCustomButton(
                title: "Show Post Normally",
                titleColor: .white,
                backgroundColor: .systemGray,
                backgroundImage: nil) {
                let vc = PostViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var showModallyButton: UIButton = {
        let button = MyCustomButton(
            title: "Show Post Modally",
            titleColor: .white,
            backgroundColor: .systemGray,
            backgroundImage: nil) {
            let vc = PostViewController()
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    private let checkTextField: UITextField = {
        let textField = MyCustomTextField(
            font: UIFont.systemFont(ofSize: 16),
            textColor: .black,
            backgroundColor: .white,
            placeholder: "Enter the word")
        
        return textField
    }()
    
    private lazy var checkButton: UIButton = {
        let button = MyCustomButton(
            title: "Check the word",
            titleColor: .white,
            backgroundColor: .systemGray,
            backgroundImage: nil) {
            let enteredWord = self.checkTextField.text
            self.checker.check(word: enteredWord ?? "")
        }
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.toAutoLayout()
        return label
    }()
    
    private let feedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.alignment = .fill
        stackView.toAutoLayout()
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        checkTextField.delegate = self
        setupViews()
        setupNotifications()

    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelColorGreen), name: NSNotification.Name(rawValue: "Green label"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelColorRed), name: NSNotification.Name(rawValue: "Red label"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLabelTransparent), name: NSNotification.Name(rawValue: "Transparent label"), object: nil)
    }
    
    @objc func changeLabelColorGreen() {
        self.colorLabel.backgroundColor = .green
        self.colorLabel.alpha = 1
    }
    
    @objc func changeLabelColorRed() {
        self.colorLabel.backgroundColor = .red
        self.colorLabel.alpha = 1
    }
    
    @objc func changeLabelTransparent() {
        self.colorLabel.alpha = 0
    }
    
    private func setupViews() {
        
        view.addSubview(feedStackView)
        
        feedStackView.addArrangedSubview(showNormallyButton)
        feedStackView.addArrangedSubview(showModallyButton)
        feedStackView.addArrangedSubview(checkTextField)
        feedStackView.addArrangedSubview(checkButton)
        feedStackView.addArrangedSubview(colorLabel)
        
        feedStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(150)
        }
    }
}

extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
