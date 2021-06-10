//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: ImageVK? {
        didSet {
            collectionImageView.image = photo?.image
        }
    }
    
    private let collectionImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .white
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(collectionImageView)
        
        let constraints = [
            collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
