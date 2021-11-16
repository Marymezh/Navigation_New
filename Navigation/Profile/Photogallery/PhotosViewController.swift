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
    private let arrayOfPhotos = PhotoStorage.photoArray
    private var arrayOfPublishedPhotos = [UIImage]()
    private let processor = ImageProcessor()
    private var processedPhotos = [UIImage]()
    
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
        photoCollectionView.backgroundColor = .white
        
        
        
        facade.addImagesWithTimer(time: 0.5, repeat: 21, userImages: arrayOfPhotos)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        facade.subscribe(self)
        
        indicator.isHidden = false
        indicator.startAnimating()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
        facade.removeSubscription(for: self)
        
        
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    private func setupCollectionView(){
        view.addSubview(photoCollectionView)
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
        indicator.toAutoLayout()
        photoCollectionView.toAutoLayout()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellID")
        
        let constraints = [
            photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
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
        
//        cell.photo = arrayOfPublishedPhotos[indexPath.item]
        

        processor.processImagesOnThread(sourceImages: arrayOfPublishedPhotos, filter: .noir, qos: .userInteractive) { processedPhotos in
            print("filtration")
//            let queue = DispatchQueue.global(qos: .utility)
//            queue.async {
                for (index, photo) in processedPhotos.enumerated() {
                    if let image = photo {
                        self.arrayOfPublishedPhotos[index] = UIImage(cgImage: image)
                    }
//                }
                
                DispatchQueue.main.sync {

                    cell.photo = self.arrayOfPublishedPhotos[indexPath.item]
                    
                }
            }
        }
        
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
 //       photoCollectionView.reloadData()
        
        let indexPath = IndexPath(item: images.count - 1, section: 0)
        photoCollectionView.insertItems(at: [indexPath])
    }
}
