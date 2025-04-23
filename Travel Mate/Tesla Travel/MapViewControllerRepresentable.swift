//
//  MapViewControllerRepresentable.swift
//  Tesla Travel
//
//  Created by Sherab Ghale on 4/22/25.
//
// The MapPage file calls this file MapViewControllerRepresentable
// and this file calls MapViewController to create a UIKit

import SwiftUI
import UIKit

// wrapper for MapViewController
struct MapViewControllerRepresentable: UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
   
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
       
    }
}

