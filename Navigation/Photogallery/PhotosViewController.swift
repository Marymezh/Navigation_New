//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let collectionCellID = "collectionCellID"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
    }
    
    private func setupCollectionView(){
        view.addSubview(photoCollectionView)
        photoCollectionView.toAutoLayout()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellID")
        
        let constraints = [
            photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }

}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
        // уточнить - посчитать количество фотографий в коллекции - тут будет массив из картинок и count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellID", for: indexPath)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (photoCollectionView.frame.width - baseInset * 4) / 3, height: photoCollectionView.frame.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return baseInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: baseInset, left: baseInset, bottom: .zero, right: baseInset)
    }
    
    private var baseInset: CGFloat { return 8 }
}

