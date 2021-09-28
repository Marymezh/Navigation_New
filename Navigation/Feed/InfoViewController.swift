//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    private lazy var removeButton: MyCustomButton = {
        let button = MyCustomButton(title: "Remove Post", titleColor: .white, backgroundColor: .black, backgroundImage: nil) {
            self.showAlert()
        }
        return button
    }()
    
    init(coordinator: FeedCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(removeButton)
        
        removeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.center.equalToSuperview()
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}