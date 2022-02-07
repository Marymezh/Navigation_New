//
//  NetworkService.swift
//  Navigation
//
//  Created by Maria Mezhova on 20.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation


struct NetworkService {
    
    static func performRequest (with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
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
    
     func performNewRequest (with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
                return
            }
            if let safeData = data {

                guard let list = serializeJSON(data: safeData) else { return }
                let random = list.randomElement()
                print (random?.title ?? "")

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
            print ("JSON Parsing error")
            return nil
        }
        
        var returnArray: [TodoListModel] = []
        for list in dictionary {
            returnArray.append(TodoListModel(from: list))
        }
        
        return returnArray
        
    }
    
}
