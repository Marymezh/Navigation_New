//
//  TableViewModelType.swift
//  Navigation
//
//  Created by Maria Mezhova on 01.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol TableViewModelType {
    var numberOfRows: Int { get }
    var postArray: [PostVK] { get }
}
