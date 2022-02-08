//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let toDoUrlString = "https://jsonplaceholder.typicode.com/todos/"
    private let planetUrlString = "https://swapi.dev/api/planets/1"
    
    private var networkService = NetworkService()
    
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
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private var planetNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private var planetInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.delegate = self
        setupUI()
        networkService.performToDoRequest(with: toDoUrlString)
        networkService.performPlanetInfoRequest(with: planetUrlString)
    }
    
    private func setupUI() {
        view.backgroundColor = .yellow
        view.addSubviews(removeButton, titleLabel, planetNameLabel, planetInfoLabel)
        
        removeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(100)
        }
        
        planetNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(titleLabel).inset(100)
        }
        
        planetInfoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(planetNameLabel).inset(50)
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

extension InfoViewController: NetworkServiceDelegate {
    func didUpdateTitleText(_ service: NetworkService, title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
        }
    }
    
    func didUpdatePlanetInfo(_ service: NetworkService, _ info: PlanetModel) {
        DispatchQueue.main.async {
            self.planetNameLabel.text = "Planet name: \(info.name)"
            self.planetInfoLabel.text = "The period of revolution of the planet \(info.name) around its star is \(info.orbitalPeriod) days"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
 
}
