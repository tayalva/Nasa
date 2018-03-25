//
//  MarsPhoto.swift
//  Nasa
//
//  Created by Taylor Smith on 3/24/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import Foundation

struct MarsResults: Codable {
    
    var results: [MarsPhoto]
}

struct MarsPhoto: Codable {
    
    var imageUrl: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        
        case imageUrl = "img_src"
        case date = "earth_date"
    }
    
}
