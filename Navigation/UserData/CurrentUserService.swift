//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class CurrentUserService: UserService {
    
    let someUser = User(userName: "Anonimus", userPicture: #imageLiteral(resourceName: "Anonim"), userStatus: "searching for the meaning")
    
    
    func returnUser(userName: String) -> User? {
        
       if userName == someUser.userName {
            return someUser
        }
            return nil
    }
}
