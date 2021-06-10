//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Maria Mezhova on 03.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: PostVK? {
        didSet {
            authorLabel.text = post?.author
            postImageView.image = UIImage(named: post?.image ?? "No Image")
            descriptionLabel.text = post?.description
            likesLabel.text = "Likes: \(post?.likes ?? 0)"
            viewsLabel.text = "Views: \(post?.views ?? 0)"
        }
    }
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        contentView.addSubviews(authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel)
        
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: baseInset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -baseInset),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: baseInset),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: postImageView.heightAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: baseInset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -baseInset),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: baseInset),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseInset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -baseInset),
        
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: baseInset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -baseInset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -baseInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private var baseInset: CGFloat { return 16 }
    
}
