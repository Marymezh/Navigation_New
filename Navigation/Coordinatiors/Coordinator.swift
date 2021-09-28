//
//  Coordinator.swift
//  Navigation
//
//  Created by Maria Mezhova on 27.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
//    var navigationController: UINavigationController { get set }

    func start()
}
