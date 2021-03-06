//
//  LocationSearchTable.swift
//  Nasa
//
//  Created by Taylor Smith on 4/5/18.
//  Copyright © 2018 Taylor Smith. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class LocationSearchTable: UITableViewController {
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate: HandleMapSearch? = nil
    
    
// This method parses and formats location names/address for search queries
    
    func parseAddress(selectedItem: MKPlacemark) -> String {
        // space
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // comma between street and city
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // space
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            
            format:"%@%@%@%@%@%@%@",
            selectedItem.subThoroughfare ?? "",firstSpace, selectedItem.thoroughfare ?? "", comma, selectedItem.locality ?? "", secondSpace, selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
}

// updates search results while typing

extension LocationSearchTable: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        //request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
            
        })
        
    }
}

// delegate methods

extension LocationSearchTable {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.passCoordinates(selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
