//
//  TrackList.swift
//  Navigation
//
//  Created by Maria Mezhova on 05.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

struct TrackList {
    static  let tracks =
        [Track(artistName: "Radiohead",
               trackName: "Creep",
               image: #imageLiteral(resourceName: "radiohead"),
               fileName: "radiohead-creep"),
         Track(artistName: "Depeche Mode",
               trackName: "Behind the wheel",
               image: #imageLiteral(resourceName: "depechemode"),
               fileName: "depeche-mode-behind-the-wheel"),
         Track(artistName: "Pink Floyd",
               trackName: "Hey you!",
               image: #imageLiteral(resourceName: "pinkfloyd"),
               fileName: "pink-floyd-hey-you"),
         Track(artistName: "The Doors",
               trackName: "Riders on the storm",
               image: #imageLiteral(resourceName: "doors"),
               fileName: "the-doors-riders-on-the-storm"),
         Track(artistName: "Archive",
               trackName: "Bullets",
               image: #imageLiteral(resourceName: "archive"),
               fileName: "archive-bullets")
        ]
    
}
