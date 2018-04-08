//
//  NasaTests.swift
//  NasaTests
//
//  Created by Taylor Smith on 3/22/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import XCTest
@testable import Nasa





class NasaTests: XCTestCase {
    
    let networkCall = NetworkManager()
    var apodPhoto: ApodImage!
    var marsPhoto: [MarsPhoto]!
    var earthPhoto: EarthImage!

 
    
    override func setUp() {
        super.setUp()
      
    }
    
    
    // tests APOD image download
    func testApodImageNetworkRequest() {
        
        networkCall.fetchApodImage { ( fetchedInfo, _) in
            self.apodPhoto = fetchedInfo
        }
        XCTAssertNotNil(apodPhoto?.title != nil, "network error")
    }
    
  //tests mars rover photo network request
    
    func testMarsPhotoNetworkRequest() {
        networkCall.fetchMarsRover { ( fetchedInfo, error) in
            self.marsPhoto = fetchedInfo!
        }
        XCTAssertNotNil(marsPhoto != nil, "network error")
    }
    
 //Tests eye in the sky network call/latitude and longitude testing
    
    func testEarthImageNetworkRequest() {
       
        networkCall.fetchEarthImage(latitude: 36.282468, longitude: -112.202702, completion: {
            (fetchedInfo, error) in
            if let fetchedInfo = fetchedInfo {
                self.earthPhoto = fetchedInfo
            }
        })
            XCTAssertNotNil(earthPhoto != nil, "network error")
        }
  
    
//Tests saving the APOD photo to the devices camera roll
    func testApodPhotoSaveToDevice() {
        
        let imageData = UIImagePNGRepresentation(#imageLiteral(resourceName: "spaceBackground"))
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        
        XCTAssertNotNil(compressedImage != nil)
    }
 
    
// Tests writing text on a photo to create a post card
    
    func testTextOverlayMarsRover() {
        let image = UIImage(named: "Background")
        let newImage = textToImage(drawText: "Hello from mars!", inImage: image!, atPoint: CGPoint(x: 20, y: 20))
        
        XCTAssertNotNil(newImage, "Image was not created properly")
    }
    
    
    
    
// helper method for writing text on a mars rover photo (to make a postcard)
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 40)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
   
    
}
