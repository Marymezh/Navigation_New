//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
//    weak var coordinator: ProfileCoordinator?

    private let facade = ImagePublisherFacade()
    private let layout = UICollectionViewFlowLayout()
    private lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let collectionCellID = "collectionCellID"
    private var arrayOfPhotos = PhotoStorage.photoArray
    private var arrayOfPublishedPhotos = [UIImage]()
    private let processor = ImageProcessor()
    
    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.isHidden = true
        view.color = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.topItem?.title = "Back"
        
        setupCollectionView()
        setupIndicator()
        processImages()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        facade.subscribe(self)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
        facade.removeSubscription(for: self)
    }
    
    private func setupCollectionView(){
        view.addSubview(photoCollectionView)
        photoCollectionView.toAutoLayout()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellID")
        photoCollectionView.backgroundColor = .white
        
        
        let constraints = [
            photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupIndicator(){
        view.addSubview(indicator)
        indicator.toAutoLayout()
        indicator.isHidden = false
        indicator.startAnimating()
        
        let constraints = [
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func processImages() {
        
        var processedImages = [UIImage]()
        
        processor.processImagesOnThread(sourceImages: arrayOfPhotos, filter: .noir, qos: .userInteractive) { [self] processedPhotos in
            print("filtration")
            
            for photo in processedPhotos {
                if let image = photo {
                    processedImages.append(UIImage(cgImage: image))
                }
            }
            
            DispatchQueue.main.async { [self] in
                
                facade.addImagesWithTimer(time: 0.5, repeat: processedImages.count, userImages: processedImages)
                indicator.stopAnimating()
                indicator.isHidden = true
            }
        }
    }
}
// указываем кол-во картинок - берем его из массива фотографий
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPublishedPhotos.count
    }
// пишем, какую именно ячейку мы будем вставлять в нашу коллекцию, а также пишем, что эта ячейка будет переиспользована
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellID", for: indexPath) as! PhotosCollectionViewCell
        
        cell.photo = arrayOfPublishedPhotos[indexPath.item]
        return cell
    }
}
// выставляем кол-во картинок в ряду и отступы
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var baseInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (photoCollectionView.frame.width - baseInset * 4) / 3, height: (photoCollectionView.frame.width - baseInset * 4) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return baseInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    // отступы для секции (сверху, снизу и по бокам)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: baseInset, left: baseInset, bottom: .zero, right: baseInset)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        arrayOfPublishedPhotos = images
        
        guard (images.count - 1) == photoCollectionView.numberOfItems(inSection: 0) else {return}
        let indexPath = IndexPath(item: images.count - 1, section: 0)
        photoCollectionView.insertItems(at: [indexPath])
    }
}
