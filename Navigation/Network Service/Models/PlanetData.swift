//
//  PlanetModel.swift
//  Navigation
//
//  Created by Maria Mezhova on 08.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation


struct PlanetData: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
    
    enum CodingKeys: String, CodingKey {
        case name, diameter, climate, gravity, terrain, population, residents, films, created, edited, url
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case surfaceWater = "surface_water"
    }
}


