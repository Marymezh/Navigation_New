//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Maria Mezhova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation



class ProfileViewModel: TableViewModelType {
    
    let postArray = PostStorage.postArray
    
    var numberOfRows: Int {
        return postArray.count
    }
    
//        weak var coordinator: ProfileCoordinator?
        
    var pushPhotos: (() -> Void)?
    
    let profileHeaderView = ProfileHeaderView()
    
}
