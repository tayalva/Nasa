//
//  EarthImageViewController.swift
//  Nasa
//
//  Created by Taylor Smith on 3/29/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Nuke
import MapKit
import CoreLocation

protocol HandleMapSearch {
    
   func passCoordinates(_ location: MKPlacemark)
    
}

class EarthImageViewController: UIViewController {
    
    let networkCall = NetworkManager()
    var earthPhoto: EarthImage!
    var latitude: Float!
    var longitude: Float!
    var resultsSearchController: UISearchController? = nil
    let locationManager = CLLocationManager()

    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
      locationManager.startUpdatingLocation()
        
      
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        
       resultsSearchController = UISearchController(searchResultsController: locationSearchTable)
       resultsSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultsSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search here!"
        navigationItem.titleView = resultsSearchController?.searchBar
        resultsSearchController?.hidesNavigationBarDuringPresentation = false
        resultsSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
       

    }
    @IBAction func locationGoButton(_ sender: Any) {
        
    latitude = Float(latTextField.text!)
    longitude = Float(longTextField.text!)
        
        networkRequest()
        
    }
    
    func networkRequest() {
        
        
        networkCall.fetchEarthImage(latitude: latitude, longitude: longitude, completion: {
            (fetchedInfo, error) in
         
            
            if let fetchedInfo = fetchedInfo {
                
                self.earthPhoto = fetchedInfo
            }
            OperationQueue.main.addOperation {
                
                
                Manager.shared.loadImage(with: URL(string: self.earthPhoto.url)!, into: self.imageView)
              
            }
            
            
        }
    )}

}

extension EarthImageViewController: HandleMapSearch, CLLocationManagerDelegate {
    
    func passCoordinates(_ location: MKPlacemark) {
        latitude = Float(location.coordinate.latitude)
        longitude = Float(location.coordinate.longitude)
       latTextField.text = "\(location.coordinate.latitude)"
       longTextField.text = "\(location.coordinate.longitude)"
        networkRequest()
    }
}
