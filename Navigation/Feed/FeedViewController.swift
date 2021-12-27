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
    
    var showPost: (()-> Void)?
    var presentPost: (() -> Void)?
    
    var myTimer: Timer?
    var timeLeft = 5
    
    private lazy var showNormallyButton: MyCustomButton = {
        let button =
            MyCustomButton(
                title: "Show Post Normally",
                titleColor: .white,
                backgroundColor: .systemGray,
                backgroundImage: nil) {
                
                self.showPost?()
            }
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var showModallyButton: MyCustomButton = {
        let button = MyCustomButton(
            title: "Show Post Modally",
            titleColor: .white,
            backgroundColor: .systemGray,
            backgroundImage: nil) {
            
            self.presentPost?()
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
    
    private lazy var checkButton: MyCustomButton = {
        let button = MyCustomButton(
            title: "Check the word",
            titleColor: .white,
            backgroundColor: .systemGray,
            backgroundImage: nil) { [self] in
            
            self.myTimer?.invalidate()
            self.timeLeft = 5
            self.myTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                

                self.colorLabel.alpha = 0
                self.timeLeft -= 1
                self.checkStatusLabel.alpha = 1
                self.checkStatusLabel.text = "\(self.timeLeft) seconds left to check"
                
                if self.timeLeft <= 0 {
                    self.checkStatusLabel.alpha = 0
                    timer.invalidate()
                    self.timeLeft = 5
                    self.onCompletion()
                }
            }
            
            guard let timer = self.myTimer else { return }
            RunLoop.current.add(timer, forMode: .common)
        }
        
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.toAutoLayout()
        return label
    }()
    
    private let checkStatusLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.backgroundColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
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
    
    private let checker: CheckTextField
    
    init(checker: CheckTextField) {
        self.checker = checker
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .cyan
        checkTextField.delegate = self
        setupViews()
    }
    
    private func onCompletion() {
        
        let enteredWord = checkTextField.text
        checker.check(word: enteredWord ?? "") { [weak self] result in
            switch  result {
            case .correct:
                self?.colorLabel.backgroundColor = .green
                self?.colorLabel.text = "Correct!"
                self?.colorLabel.textAlignment = .center
                self?.colorLabel.textColor = .white
                self?.colorLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                self?.colorLabel.alpha = 1
            case .incorrect:
                self?.colorLabel.backgroundColor = .red
                self?.colorLabel.text = "Incorrect!"
                self?.colorLabel.textAlignment = .center
                self?.colorLabel.textColor = .white
                self?.colorLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                self?.colorLabel.alpha = 1
            default: self?.colorLabel.alpha = 0
                
            }
        }
    }
    
    private func setupViews() {
        
        view.addSubview(feedStackView)
        
        feedStackView.addArrangedSubview(showNormallyButton)
        feedStackView.addArrangedSubview(showModallyButton)
        feedStackView.addArrangedSubview(checkTextField)
        feedStackView.addArrangedSubview(checkButton)
        feedStackView.addArrangedSubview(colorLabel)
        feedStackView.addArrangedSubview(checkStatusLabel)
        
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
