//
//  MapViewController.swift
//  Tesla Travel
//
//  Created by SherabGhale on 4/21/25.
//
// This page is for the full screen map view which sets SF as the default location
// It is called by the MapViewControllerRepresentable file

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView = MKMapView(frame: self.view.frame) //right now i'm filling the entire screen with the map
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight] //resize for different devices
        
        
        let initialLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // default location: SF
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        self.view.addSubview(mapView)
    }
}

