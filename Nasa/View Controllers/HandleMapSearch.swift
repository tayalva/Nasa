//
//  HandleMapSearch.swift
//  Nasa
//
//  Created by Taylor Smith on 4/7/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import Foundation
import MapKit

// Custom protocol to be able to pass information from the search table back to the earth iamge view controller

protocol HandleMapSearch {
    
    func passCoordinates(_ location: MKPlacemark)
    
}
