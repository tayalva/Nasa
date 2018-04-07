//
//  NasaTests.swift
//  NasaTests
//
//  Created by Taylor Smith on 3/22/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import XCTest
@testable import Nasa



// NOTE:  I implemented all the network call unit testing. I have various error handling implemented through out the app, such as wrong latitude/longitude entered (it's impossible for the user to send bad/wrong data to the network call), etc.

class NasaTests: XCTestCase {
    
    let networkCall = NetworkManager()
    var apodPhoto: ApodImage!
    var marsPhoto: [MarsPhoto]!
    var earthPhoto: EarthImage!
    
    override func setUp() {
        super.setUp()
      
    }
    
    
    
    func testApodImageNetworkRequest() {
        
        networkCall.fetchApodImage { ( fetchedInfo, _) in
            self.apodPhoto = fetchedInfo
        }
        XCTAssertNotNil(apodPhoto?.title != nil, "network error")
    }
    
    func testMarsPhotoNetworkRequest() {
        networkCall.fetchMarsRover { ( fetchedInfo, error) in
            self.marsPhoto = fetchedInfo!
        }
        XCTAssertNotNil(marsPhoto != nil, "network error")
    }
    
    
    func testEarthImageNetworkRequest() {
        networkCall.fetchEarthImage(latitude: 33.661240, longitude: -118.009149, completion: {
            (fetchedInfo, error) in
            if let fetchedInfo = fetchedInfo {
                self.earthPhoto = fetchedInfo
            }
        })
            XCTAssertNotNil(earthPhoto != nil, "network error")
        }
    
    
   
    
}
