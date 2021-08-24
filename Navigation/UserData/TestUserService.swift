//
//  TestUserService.swift
//  Navigation
//
//  Created by Maria Mezhova on 11.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


class TestUserService: UserService {

    let testUser = User(userName: "Test", userPicture: #imageLiteral(resourceName: "test"), userStatus: "testing the test")


    func returnUser(userName: String) -> User? {

       if userName == testUser.userName {
            return testUser
        }
            return nil
    }
}
