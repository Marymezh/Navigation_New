//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 23.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let arrayOfPosts = PostStorage.postArray
    var profileHeaderView = ProfileHeaderView()
    var animationView = UIView()
    var crossButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
        setUpAnimationViews()
        profileHeaderView.userPicture.layer.zPosition = 1
 
        profileHeaderView.bringSubviewToFront(profileHeaderView.userPicture)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        
        profileHeaderView.userPicture.isUserInteractionEnabled = true
        profileHeaderView.userPicture.addGestureRecognizer(imageTap)
    }

    @objc func tap() {
        animation()
    }
    
    func animation() {
        UIView.animate(withDuration: 3, animations: {
            self.profileHeaderView.userPicture.center = self.view.center
            self.profileHeaderView.userPicture.transform = CGAffineTransform.init(scaleX: 3.5, y: 3.5)
            self.profileHeaderView.userPicture.layer.cornerRadius = 0
            self.crossButton.alpha = 1
            self.animationView.alpha = 0.7
            self.profileHeaderView.profileAnimationView.alpha = 0.7
            
        })
    }
    
    private func setUpAnimationViews() {
        
        view.addSubview(crossButton)
        tableView.addSubview(animationView)
        animationView.toAutoLayout()
        animationView.backgroundColor = .white
        animationView.alpha = 0
        
        crossButton.toAutoLayout()
        crossButton.setBackgroundImage(UIImage (systemName: "clear"), for: .normal)
        crossButton.backgroundColor = .white
        crossButton.alpha = 0

        let constraints = [
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            crossButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            crossButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            crossButton.widthAnchor.constraint(equalToConstant: 30),
            crossButton.heightAnchor.constraint(equalTo: crossButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        
       
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return arrayOfPosts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            
            return cell
            
        default:
            let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            
            cell.post = arrayOfPosts[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerView = profileHeaderView
            return headerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
        let destination = PhotosViewController()
        navigationController?.pushViewController(destination, animated: true)
        } else {
        return tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

}
