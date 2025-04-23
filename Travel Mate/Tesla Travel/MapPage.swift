//
//  MapPage.swift
//  Tesla Travel
//
//  Created by Sherab Ghale on 4/22/25.
//
// This file calls MapViewControllerRepresentable when it wants to show a map

import SwiftUI

struct MapPage: View {
    var body: some View {
        VStack {
            Text("Charging Station Discovering Map")
                .font(.largeTitle)
                .padding(.bottom)
            
            MapViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
    
    }
}
