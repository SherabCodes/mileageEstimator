import SwiftUI
import MapKit

struct ContentView: View {
    // State variables to hold user input and results
    @State private var fromLocation: String = ""
    @State private var toLocation: String = ""
    @State private var batteryPercentage: Double = 80 // Default battery level (user can adjust)
    @State private var distanceCoverage: Double? // Calculated distance coverage (%)
    @State private var showNavigationSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // 1. Tesla Car Image (3D or high-res)
            Image("teslamodelx") // Replace with your asset
                .resizable()
                .scaledToFit()
                .frame(height: 150)
        }
    }
}
#Preview {
    ContentView()
}
