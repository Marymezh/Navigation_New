//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Maria Mezhova on 30.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation



class ProfileViewModel {
    
    let postArray = PostStorage.postArray
    var numberOfRows: Int {
        return postArray.count
    }
    var pushPhotos: (() -> Void)?
    let profileHeaderView = ProfileHeaderView()
    
}
