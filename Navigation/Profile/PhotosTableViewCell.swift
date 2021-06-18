//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView(image: UIImage (systemName: "arrow.forward"))
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photosImageView1: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "mKoEtc5uwBA"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photosImageView2: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "fMTsqrhT8XY"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photosImageView3: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "VUhd1KPmOkc"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    private let photosImageView4: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "uhCajd7X6mU"))
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.toAutoLayout()
        return image
    }()
    
    let photosStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.toAutoLayout()
        return stackView
    }()
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
 
        contentView.addSubviews(photosLabel, arrowImage, photosStack)
        
        photosStack.addArrangedSubview(photosImageView1)
        photosStack.addArrangedSubview(photosImageView2)
        photosStack.addArrangedSubview(photosImageView3)
        photosStack.addArrangedSubview(photosImageView4)
       
        contentView.backgroundColor = .white

        let constraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sideInset),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            
            arrowImage.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset),
            arrowImage.widthAnchor.constraint(equalToConstant: 30),
            arrowImage.heightAnchor.constraint(equalTo: arrowImage.widthAnchor),
            
            photosStack.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: sideInset),
            photosStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            photosStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset),
            photosStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -sideInset),
            photosStack.heightAnchor.constraint(equalToConstant: (contentView.frame.size.width - sideInset * 2 - baseInset * 3) / 4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    private var baseInset: CGFloat { return 8 }
    private var sideInset: CGFloat { return 12 }
}

