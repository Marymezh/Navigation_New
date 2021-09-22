//
//  MyCustomButton.swift
//  Navigation
//
//  Created by Maria Mezhova on 05.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MyCustomButton: UIButton {
    
    private let buttonAction: () -> Void
    
    init(title: String?, titleColor: UIColor?, backgroundColor: UIColor?, backgroundImage: UIImage?, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.setBackgroundImage(backgroundImage, for: .normal)
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
