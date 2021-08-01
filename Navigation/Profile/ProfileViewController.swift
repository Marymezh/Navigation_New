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
    private let profileHeaderView = ProfileHeaderView()
    
    
    private let animationView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setBackgroundImage(UIImage (systemName: "clear"), for: .normal)
        button.backgroundColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(tapClearButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
        setUpAnimationViews()
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        
        profileHeaderView.userPicture.isUserInteractionEnabled = true
        profileHeaderView.userPicture.addGestureRecognizer(imageTap)
    }

    @objc func tap() {
        animation()
    }

    func animation() {
        
      
        UIView.animate(withDuration: 0.5, animations: {
            self.profileHeaderView.userPicture.center = self.view.center
            self.profileHeaderView.userPicture.transform = CGAffineTransform.init(scaleX: 0.99 , y: 0.99 )
            self.profileHeaderView.userPicture.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width)

            self.profileHeaderView.userPicture.layer.cornerRadius = 0
            self.animationView.alpha = 0.7
            self.profileHeaderView.profileAnimationView.alpha = 0.7
            
        }, completion: {_ in
            
            UIView.animate(withDuration: 0.3, animations: {
                self.clearButton.alpha = 1
            })
        })
    }
    
    @objc private func tapClearButton() {
     reversedAnimation()
        
    }
    
    func reversedAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.clearButton.alpha = 0
            
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, animations: {
                self.profileHeaderView.userPicture.frame = CGRect(x: 16, y: 16, width: 110, height: 110)
                self.profileHeaderView.userPicture.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.profileHeaderView.userPicture.layer.cornerRadius = 55
                self.animationView.alpha = 0
                self.profileHeaderView.profileAnimationView.alpha = 0
                
            })
        })
    }
    
    private func setUpAnimationViews() {
        
        view.addSubview(clearButton)
        tableView.addSubview(animationView)

        let constraints = [
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            clearButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearButton.widthAnchor.constraint(equalToConstant: 30),
            clearButton.heightAnchor.constraint(equalTo: clearButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        
        #if DEBUG
        tableView.backgroundColor = .green
        #else
        tableView.backgroundColor = .systemGray6
        #endif
        
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
            let photosVC = storyboard?.instantiateViewController(identifier: "PhotosVC") as! PhotosViewController
            navigationController?.pushViewController(photosVC, animated: true)
        } else {
        return tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

}
