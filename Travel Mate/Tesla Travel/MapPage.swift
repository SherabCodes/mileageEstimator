//
//  MapPage.swift
//  Tesla Travel
//
//  Created by Sherab  on 4/22/25.
//
// Purpose; This file calls MapViewControllerRepresentable when it wants to show a map

import SwiftUI

struct MapPage: View {
    var body: some View {
        VStack {
            Text("Charging Stations")
                .font(.largeTitle)
                .padding(.bottom)
            
            MapViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
    
    }
}
