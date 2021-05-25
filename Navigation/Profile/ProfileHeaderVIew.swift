//
//  ProfileHeaderVIew.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
   
   private let userPicture = UIImageView(image: UIImage(named: "mysterious-cat.jpg"))
   private let userName = UILabel()
   private let userStatus = UILabel()
   private let statusButton = UIButton()
   private let setStatus = UITextField()
   private var statusText = String()

   override init(frame: CGRect) {
       super.init(frame: frame)
        addSubviews()
        setupUI()
   }
   
   required init?(coder: NSCoder) {
       super.init(coder: coder)
   }
   
   override func layoutSubviews() {
       configureFrames()
   }
   
    func addSubviews() {
        addSubview(userPicture)
        addSubview(userName)
        addSubview(userStatus)
        addSubview(statusButton)
        addSubview(setStatus)
    }
    
    func setupUI() {
        userPicture.layer.borderWidth = 3.0
        userPicture.layer.borderColor = UIColor.white.cgColor
        userPicture.clipsToBounds = true
    
        userName.text = "Mysterious Cat"
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.textColor = .black
    
        userStatus.text = "Learning how to code..."
        userStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        userStatus.textColor = .gray
    
        statusButton.setTitle("Set status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.layer.backgroundColor = UIColor.blue.cgColor
        statusButton.layer.cornerRadius = 14
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
    
        setStatus.leftViewMode = .always
        setStatus.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        setStatus.textColor = .black
        setStatus.backgroundColor = .white
        setStatus.layer.borderWidth = 1.0
        setStatus.layer.borderColor = UIColor.black.cgColor
        setStatus.layer.cornerRadius = 12
        setStatus.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
   }
   
   func configureFrames() {
       userPicture.frame = CGRect(x: self.safeAreaInsets.left + 16, y: self.safeAreaInsets.top + 16, width: 110, height: 110)
       userPicture.layer.cornerRadius = userPicture.frame.size.width/2
       userName.frame = CGRect(x: self.safeAreaInsets.left + 150, y: self.safeAreaInsets.top + 27, width: 300, height: 18)
       userStatus.frame = CGRect(x: self.safeAreaInsets.left + 150, y: statusButton.frame.minY - userStatus.bounds.height - 60, width: 300, height: 14)
       statusButton.frame = CGRect(x: self.safeAreaInsets.left + 16, y: userPicture.frame.maxY + 32 , width: self.bounds.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 16 * 2, height: 50)
       setStatus.frame = CGRect(x: self.safeAreaInsets.left + 150, y: statusButton.frame.minY - setStatus.bounds.height - 10, width: self.bounds.width - self.safeAreaInsets.left - self.safeAreaInsets.right - 166, height: 40)
       setStatus.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: setStatus.frame.height))
   }
   
    @objc func statusTextChanged(_ textField: UITextField)  {
       statusText = setStatus.text ?? "No status"
   }
   
    @objc func buttonIsPressed() {
       userStatus.text = statusText
   }
}
