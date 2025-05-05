//
//  MapViewController.swift
//  Tesla Travel
//
//  Created by SherabGhale on 4/21/25.
//
// This page is for the full screen map view which sets SF as the default location
// It is called by the MapViewControllerRepresentable file


// comments on new changes
//added a CLLocationManager to request and manage location permissions. If granted,the map's region is updated to the user's current location.
// Once the user’s location is available, a search is performed using MKLocalSearch to find nearby charging stations (apple map's data)

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the map view
        mapView = MKMapView(frame: self.view.frame)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // default location is San Francisco (until user allows the app to access their location)
        let initialLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // SF
        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        
        self.view.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
       
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate is called when location permission is granted
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    // updates the user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        userLocation = location.coordinate
        
        
        searchNearbyChargingStations()
    }


    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    // allows search for nearby charging stations
    func searchNearbyChargingStations() {
        guard let userLocation = userLocation else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "charging station"
        request.region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error searching for charging stations: \(error.localizedDescription)")
                return
            }
            
            if let mapItems = response?.mapItems {
                self.addChargingStationsAnnotations(mapItems)
            }
        }
    }
    
    func addChargingStationsAnnotations(_ mapItems: [MKMapItem]) {
        var annotations = [MKPointAnnotation]()
        
        for item in mapItems {
            let annotation = MKPointAnnotation()
            annotation.title = item.name
            annotation.coordinate = item.placemark.coordinate
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
}
