//
//  ProfileHeaderVIew.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var setStatusButton: UIButton!
    
    private var statusText = String()
    
        override func awakeFromNib() {
            avatarImageView.layer.borderWidth = 3.0
            avatarImageView.layer.borderColor = UIColor.white.cgColor
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
            avatarImageView.clipsToBounds = true
    
            fullNameLabel.text = "Mysterious Cat"
            fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            fullNameLabel.textColor = .black
    
            statusLabel.text = "Learning how to code..."
            statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            statusLabel.textColor = .gray
    
            setStatusButton.setTitle("Set status", for: .normal)
            setStatusButton.setTitleColor(.white, for: .normal)
            setStatusButton.layer.backgroundColor = UIColor.blue.cgColor
            setStatusButton.layer.cornerRadius = 14
            setStatusButton.layer.shadowColor = UIColor.black.cgColor
            setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
            setStatusButton.layer.shadowOpacity = 0.7
            setStatusButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
    
    
            statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: setStatusButton.frame.height))
            statusTextField.leftViewMode = .always
            statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            statusTextField.textColor = .black
            statusTextField.backgroundColor = .white
            statusTextField.layer.borderWidth = 1.0
            statusTextField.layer.borderColor = UIColor.black.cgColor
            statusTextField.layer.cornerRadius = 12
            statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        }
    
        @objc func statusTextChanged(_ textField: UITextField)  {
            statusText = statusTextField.text ?? "No status"
        }
    
        @objc func buttonIsPressed() {
            statusLabel.text = statusText
        }
}

