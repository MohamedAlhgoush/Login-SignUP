//
//  PlacesViewController.swift
//  Login and SignUp
//
//  Created by Mohamed Alghoush  on 8/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps



class PlacesViewController: UIViewController {
    
     var MapView: GMSMapView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func UnwindToMain(_ sender: Any) {
        // Clear the map.
        MapView?.clear()
        
        // Add a marker to the map.
        if selectedPlace != nil {
            let marker = GMSMarker(position: (self.selectedPlace?.coordinate)!)
            marker.title = selectedPlace?.name
            marker.snippet = selectedPlace?.formattedAddress
            marker.map = MapView
        }
        
//        listLikelyPlaces()
    }
    
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMain" {
            if let nextViewController = segue.destination as? HomeViewController {
                nextViewController.selectedPlace = selectedPlace
            }
        }
        }
}


// Populate the table with the list of most likely places.
extension PlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlace = likelyPlaces[indexPath.row]
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likelyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIFontFeatureTypeIdentifierKey, for: indexPath)
        let collectionItem = likelyPlaces[indexPath.row]
        
        cell.textLabel?.text = collectionItem.name
        
        return cell
    }
    
  // Show only the first five items in the table (scrolling is disabled in IB).
// func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////   return self.performence.frame.size.height/5
//    return self.tableView.frame.size.height/5
//  }
    
    // Make table rows display at proper height if there are less than 5 items.
    private func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        }
        return 0
    }
}
