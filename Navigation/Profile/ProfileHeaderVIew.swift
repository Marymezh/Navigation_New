//
//  ProfileHeaderVIew.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let userPicture: UIImageView =  {
        var image = UIImageView(image: #imageLiteral(resourceName: "mysterious-cat"))
        image.layer.borderWidth = 3.0
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 55
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
    return image
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "Mysterious Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
    return label
    }()
    
    private let userStatus: UILabel = {
        let label = UILabel()
        label.text = "Learning how to code..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.toAutoLayout()
        button.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
    return button
    }()
    
    private let setStatus: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.placeholder = "Set your status"
        textField.toAutoLayout()
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
        
    private var statusText = String()
    
   @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubviews(userPicture, userName, userStatus, setStatus, statusButton)

        let constraints = [
            userPicture.topAnchor.constraint(equalTo: self.topAnchor, constant: baseInset),
            userPicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: baseInset),
            userPicture.heightAnchor.constraint(equalToConstant: 110),
            userPicture.widthAnchor.constraint(equalTo: userPicture.heightAnchor),
            
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            userName.leadingAnchor.constraint(equalTo: userPicture.trailingAnchor, constant: baseInset),
            userName.heightAnchor.constraint(equalToConstant: 18),
            
            statusButton.topAnchor.constraint(equalTo: userPicture.bottomAnchor, constant: 32),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: baseInset),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -baseInset),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -baseInset),
            
            setStatus.leadingAnchor.constraint(equalTo: userPicture.trailingAnchor, constant: baseInset),
            setStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -baseInset),
            setStatus.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -10),
            setStatus.heightAnchor.constraint(equalToConstant: 40),
            
            userStatus.leadingAnchor.constraint(equalTo: userPicture.trailingAnchor, constant: baseInset),
            userStatus.bottomAnchor.constraint(equalTo: setStatus.topAnchor, constant: -10),
            userStatus.heightAnchor.constraint(equalToConstant: 14)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private var baseInset: CGFloat { return 16 }
    
    @objc func statusTextChanged(_ textField: UITextField)  {
        statusText = setStatus.text ?? "No status"
    }
    
    @objc func buttonIsPressed() {
        userStatus.text = statusText
    }
}

