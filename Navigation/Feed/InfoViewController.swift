//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
   private let urlString = "https://jsonplaceholder.typicode.com/todos/"
private let networkService = NetworkService()
    
    private lazy var removeButton: MyCustomButton = {
        let button = MyCustomButton(title: "Remove Post", titleColor: .white, backgroundColor: .black, backgroundImage: nil) {
            self.showAlert()
        }
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray
        label.toAutoLayout()
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        networkService.performNewRequest(with: urlString)
        
        print("decoding from: \(urlString)")
    }
    
    private func setupUI() {
        view.backgroundColor = .yellow
        view.addSubviews(removeButton, titleLabel)
        
        removeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.top.equalToSuperview().inset(100)
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
    
//    private func fetchData() {
//        let urlString = "https://jsonplaceholder.typicode.com/todos/"
//        guard let url = URL(string: urlString) else  { return }
//        let dataTask = NetworkService.performNewRequest1(with: url) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .failure(let error):
//                print("NetworkService failure: \(error.localizedDescription)")
//            case .success(let (_, data)):
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        let todolist = TodosModel(id: json["id"], userId: json["userID"], title: json["title"], completed: json["completed"]) {
//                            DispatchQueue.main.async {
//                                self.titleLabel.text = todolist.title
//                            }
//                        }
//                    } else {
//                        print("JSON data has unknown format")
//                    }
//                } catch {
//                    print("Data parsing failed")
//                }
//            }
//        }
//        dataTask.resume()
//    }
}
