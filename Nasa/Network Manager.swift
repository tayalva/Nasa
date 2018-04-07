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
    var earthUrl = "https://api.nasa.gov/planetary/earth/imagery/"
    
    func fetchMarsRover(completion: @escaping ([MarsPhoto]?, Error?)-> Void) {
        
        let url = "\(marsRoverUrl)\(apiKey)"
        
        let apiUrl = URL(string: url)!
        
        URLSession.shared.dataTask(with: apiUrl) {
            (data, response, error) in
            
            guard let responseData = data else {
                
                print("no data!")
                
                completion(nil, error)
                
               
                return
            }
            
           let decoder = JSONDecoder()
            if let marsArray = try? decoder.decode(MarsResults.self, from: responseData) {
                

                
                completion(marsArray.photos, nil)
            } else {
                
                print("not decoded properly")
                
               
            }

        } .resume()
    }
    
    func fetchEarthImage(latitude: Float, longitude: Float, completion: @escaping (EarthImage?, Error?) -> Void) {
    
    
        let url = "\(earthUrl)?lon=\(longitude)&lat=\(latitude)&date=2014-02-01&cloud_score=false&api_key=\(apiKey)"
        
        let apiUrl = URL(string: url)!
        
        URLSession.shared.dataTask(with: apiUrl) {
            (data, response, error) in
            
            guard let responseData = data else {
                
                print("no data for earth api!")
                completion(nil, error)
                
                return
            }

            let decoder = JSONDecoder()
            if let earthImage = try? decoder.decode(EarthImage.self, from: responseData){
            
            
                completion(earthImage, nil)
                
            } else {
                
                print("earth photo not decoded properly")
                completion(nil, error)
           
            }
            
        } .resume()
    }

    
    func fetchApodImage(completion: @escaping (ApodImage?, Error?)-> Void) {
        
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        let apiUrl = URL(string: url)!
        
        
        URLSession.shared.dataTask(with: apiUrl) {
            (data, response, error) in
            
            guard let responseData = data else {
                print("no data from APOD")
                
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            if let apodImage = try? decoder.decode(ApodImage.self, from: responseData) {
                
                completion(apodImage, nil)
            } else {
                print("APOD not decoded properly")
            }
            
            
        } .resume()
        
    }
    
}















