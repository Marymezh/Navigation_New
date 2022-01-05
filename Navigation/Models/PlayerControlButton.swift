//
//  PlayerControlButton.swift
//  Navigation
//
//  Created by Maria Mezhova on 05.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

class PlayerControlButton: UIButton {
    
    private let buttonAction: () -> Void
    
    init(image: String, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
        let image = UIImage(systemName: image)
        self.setImage(image, for: .normal)
        self.tintColor = .black
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.toAutoLayout()
        
        self.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
    }
    
    @objc private func buttonIsTapped() {
        self.buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
