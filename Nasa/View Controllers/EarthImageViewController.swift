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
    
    
// Search bar setup/UI and delegate set up
    
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
        latTextField.keyboardType = .decimalPad
        longTextField.keyboardType = .decimalPad

    }
    
// triggers a network request with the latitude and longitude from the textfields (address search also populates these fields, why not? :) )
    @IBAction func locationGoButton(_ sender: Any) {
        latitude = Float(latTextField.text!)
        longitude = Float(longTextField.text!)
        networkRequest()
    }

// network request/error handling for improper usage or invalid data
    
    func networkRequest() {
        
        if latTextField.text == "" || longTextField.text == "" || latitude == nil || longitude == nil {
            let alert = UIAlertController(title: "Ruh Roh!", message: "Please enter in valid coordinates, or search above for an address!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in })
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
        networkCall.fetchEarthImage(latitude: latitude, longitude: longitude, completion: {
            (fetchedInfo, error) in
            if let fetchedInfo = fetchedInfo {
                self.earthPhoto = fetchedInfo
            OperationQueue.main.addOperation {
                Manager.shared.loadImage(with: URL(string: self.earthPhoto.url)!, into: self.imageView)
            }
            } else {
                
                OperationQueue.main.addOperation {
                let alert = UIAlertController(title: "Ruh Roh!", message: "Please enter in valid coordinates, or search above for an address!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in })
                self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    )}
    }
}

// delegate that passes information from the search table back to the earth image view controller

extension EarthImageViewController: HandleMapSearch, CLLocationManagerDelegate {
    
    func passCoordinates(_ location: MKPlacemark) {
        latitude = Float(location.coordinate.latitude)
        longitude = Float(location.coordinate.longitude)
        latTextField.text = "\(location.coordinate.latitude)"
        longTextField.text = "\(location.coordinate.longitude)"
        networkRequest()
        }
}
