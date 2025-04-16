//
//  LocalManager.swift
//  Tesla Travel
//
//  Created by Sienna Ni on 2025/4/11.
//
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var userLocation: CLLocation?
    @Published var userAddress: String = "Fetching..."

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        reverseGeocode(location)
    }

    func reverseGeocode(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.userAddress = placemark.locality ?? "Unknown"
                }
            }
        }
    }
}
