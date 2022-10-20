//
//  NetworkService.swift
//  Navigation
//
//  Created by Maria Mezhova on 20.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

protocol  NetworkServiceDelegate {
    func didUpdateTitleText(_ service: NetworkService, title: String)
    func didUpdatePlanetInfo(_ service: NetworkService,_ info: PlanetModel)
    func didFailWithError(error: Error)
}

struct NetworkService {
    
    var delegate: NetworkServiceDelegate?

    static func performRequest (with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
                
                // In case of wifi connection switched off, message in debug console is:
                // Error Domain=NSURLErrorDomain Code=-1009 "The Internet connection appears to be offline."
                return
            }
            if let safeData = data, let urlResponse = response as? HTTPURLResponse {
                let dataString = String(data: safeData, encoding: .utf8)
                print ("Data: \(dataString ?? "")")
                print ("Response code: \(urlResponse.statusCode)")
                print ("Response header fields:\(urlResponse.allHeaderFields)")
            }
        }
        
        task.resume()
    }
    
    func performToDoRequest (with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data {
                guard let list = serializeJSON(data: safeData) else { return }
                let random = list.randomElement()
                self.delegate?.didUpdateTitleText(self, title: random?.title ?? "")
            } else {
                print("Error with fetching data")
            }
        }
        
        task.resume()
    }
    
    func serializeJSON (data: Data) -> [TodoListModel]? {
        
        var dictionary: [[String: Any]]
        do {
            guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                print ("Downcasting error")
                return nil
            }
            dictionary = dict
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        var returnArray: [TodoListModel] = []
        for list in dictionary {
            returnArray.append(TodoListModel(from: list))
        }
        
        return returnArray
    }
    
    func performPlanetInfoRequest(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data {
                guard let info = parseJSON(safeData) else { return }
                self.delegate?.didUpdatePlanetInfo(self, info)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(_ planetInfoData: Data) -> PlanetModel? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(PlanetData.self, from: planetInfoData)
            
            let name = decodedData.name
            let rotationP = decodedData.rotationPeriod
            let orbitalP = decodedData.orbitalPeriod
            let diameter = decodedData.diameter
            let climate = decodedData.climate
            let gravity = decodedData.gravity
            let terrain = decodedData.terrain
            
            let planetInfo = PlanetModel(name: name, rotationPeriod: rotationP, orbitalPeriod: orbitalP, diameter: diameter, climate: climate, gravity: gravity, terrain: terrain)
            return planetInfo
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
