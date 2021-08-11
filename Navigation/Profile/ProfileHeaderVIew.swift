//
//  ProfileHeaderVIew.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    var userPicture: UIImageView =  {
        var image = UIImageView(image: #imageLiteral(resourceName: "mysterious-cat"))
        image.layer.borderWidth = 3.0
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 55
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.toAutoLayout()
        return image
    }()
    
     var userName: UILabel = {
        let label = UILabel()
        label.text = "Mysterious Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
     var userStatus: UILabel = {
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
    
    let profileAnimationView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.toAutoLayout()
        return view
    }()
        
    private var statusText = String()

    @available(*, unavailable)
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override init(frame: CGRect) {
         super.init(frame: frame)
        
        self.addSubviews(userPicture, userName, userStatus, setStatus, statusButton)
        self.addSubview(profileAnimationView)
        
        self.bringSubviewToFront(userPicture)
        
        userPicture.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(baseInset)
            make.leading.equalToSuperview().inset(baseInset)
            make.height.width.equalTo(110)
        }

        userName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.equalTo(userPicture.snp.trailing).offset(baseInset)
            make.height.equalTo(18)
        }

        statusButton.snp.makeConstraints { make in
            make.top.equalTo(userPicture.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(baseInset)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(baseInset)
        }

        setStatus.snp.makeConstraints { make in
            make.leading.equalTo(userPicture.snp.trailing).offset(baseInset)
            make.trailing.equalToSuperview().inset(baseInset)
            make.bottom.equalTo(statusButton.snp.top).inset(-10)
            make.height.equalTo(40)
        }

        userStatus.snp.makeConstraints { make in
            make.leading.equalTo(userPicture.snp.trailing).offset(baseInset)
            make.bottom.equalTo(setStatus.snp.top).inset(-10)
            make.height.equalTo(14)
        }
        
        profileAnimationView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private var baseInset: CGFloat { return 16 }
    
    @objc func statusTextChanged(_ textField: UITextField)  {
        statusText = setStatus.text ?? "No status"
    }
    
    @objc func buttonIsPressed() {
        userStatus.text = statusText
    }
}

