import SwiftUI

enum Route: Hashable {
    case map
}

struct HomePage: View {
    @State private var selectedTab = 0
    @State private var path = NavigationPath()
    
    
    // Dummy location list
    let locations = ["New York", "Los Angeles", "Chicago", "San Francisco", "Seattle"]
    
    @State private var selectedStart = "New York"
    @State private var selectedDestination = "Los Angeles"
    @State private var batteryCoverage = 90 // Replace with dynamic value later
    //@State private var showMapPage = false
    
    var body: some View {
        NavigationStack(path: $path){ //changes I made (wrapped it all in NavigationStack
                VStack(spacing: 30) {
                    // Car Image
                    Image("teslamodelx") // Replace with a custom image if desired
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundColor(.blue)
                        .padding(.top, 40)
                    
                    // Starting Point Picker
                    VStack(alignment: .leading) {
                        Text("Starting Point")
                            .font(.headline)
                        Picker("Starting Point", selection: $selectedStart) {
                            ForEach(locations, id: \.self) { location in
                                Text(location)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Destination Picker
                    VStack(alignment: .leading) {
                        Text("Destination")
                            .font(.headline)
                        Picker("Destination", selection: $selectedDestination) {
                            ForEach(locations, id: \.self) { location in
                                Text(location)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    // Battery Coverage Indicator
                    VStack {
                        Text("Battery Coverage")
                            .font(.headline)
                        Text("\(batteryCoverage)%")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.green)
                    }
                    .padding(.top, 40)
                    
                    
                    
                    Button ("Discover Charging Stations"){
                        path.append(Route.map)
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    
                    Spacer()
                }
            
                .navigationDestination(for: Route.self) { route in
                    switch route{
                    case .map:
                        MapViewControllerRepresentable()
                            .navigationTitle("Charging Stations")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    
                }
        }
       
    }
}
