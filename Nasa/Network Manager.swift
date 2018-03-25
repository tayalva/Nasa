//
//  Network Manager.swift
//  Nasa
//
//  Created by Taylor Smith on 3/22/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import Foundation


class NetworkManager {
    
    var apiKey = "2kSGhaEg9bl1RZpsb2jLlqMxqXwMLrSprNXr5eMG"
    
    var marsRoverUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=1&api_key="
    var earthUrl = "https://api.nasa.gov/planetary/earth/imagery?lon=100.75&lat=1.5&date=2014-02-01&cloud_score=True&api_key="
    
    func fetchMarsRover(completion: @escaping ([MarsPhoto]?, Error?)-> Void) {
        
        let url = "\(marsRoverUrl)\(apiKey)"
        
        let apiUrl = URL(string: url)!
        
        URLSession.shared.dataTask(with: apiUrl) {
            (data, response, error) in
            
            guard let responseData = data else {
                
                print("no data!")
                return
            }
            
           let decoder = JSONDecoder()
            if let marsArray = try? decoder.decode(MarsResults.self, from: responseData) {
                
                completion(marsArray.results, nil)
            } else {
                
                print("not decoded properly")
            }
            
         
            
        } .resume()
    }
    
    
}
