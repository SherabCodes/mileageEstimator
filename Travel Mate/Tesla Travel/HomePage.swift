import SwiftUI
import MapKit
import CoreLocation

enum Route: Hashable {
    case map
}

struct HomePage: View {
    @State private var selectedTab = 0
    @State private var path = NavigationPath()

    // Dummy location list
    // Realistic Bay Area locations (~10–80 km distances)
        let locations = [
            "San Francisco, CA",
            "Oakland, CA",
            "San Jose, CA",
            "Palo Alto, CA",
            "Berkeley, CA",
            "Fremont, CA",
            "Mountain View, CA",
            "Sunnyvale, CA"
        ]

    @State private var selectedStart = "San Francisco, CA"
    @State private var selectedDestination = "Berkeley, CA"
    @State private var batteryCoverage = 100
    @State private var isLoading = false

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 30) {
                    // Car Image
                    Image("teslamodelx")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
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

                    // Battery Coverage Display
                    VStack {
                        Text("Battery Coverage")
                            .font(.headline)

                        if isLoading {
                            ProgressView()
                        } else {
                            Text("\(batteryCoverage)%")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(batteryCoverage > 30 ? .green : .red)
                            ProgressView(value: Double(batteryCoverage), total: 100)
                                .accentColor(batteryCoverage > 30 ? .green : .red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 40)

                    // Navigate to Map
                    Button("Discover Charging Stations") {
                        path.append(Route.map)
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(selectedStart == selectedDestination)

                    Spacer()
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .map:
                        MapViewControllerRepresentable()
                            .navigationTitle("Charging Stations")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .onChange(of: selectedStart) { _ in
                    updateBatteryCoverage()
                }
                .onChange(of: selectedDestination) { _ in
                    updateBatteryCoverage()
                }
                .onAppear {
                    updateBatteryCoverage()
                }
            }
        }
    }

    func updateBatteryCoverage() {
        isLoading = true
        BatteryEstimator.estimateBatteryUsage(from: selectedStart, to: selectedDestination) { estimated in
            DispatchQueue.main.async {
                self.batteryCoverage = estimated ?? 0
                self.isLoading = false
            }
        }
    }
}

// BatteryEstimator helper
class BatteryEstimator {
    static func estimateBatteryUsage(from: String, to: String, completion: @escaping (Int?) -> Void) {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(from) { fromPlacemarks, _ in
            guard let fromPlacemark = fromPlacemarks?.first,
                  let fromLocation = fromPlacemark.location else {
                completion(nil)
                return
            }

            geocoder.geocodeAddressString(to) { toPlacemarks, _ in
                guard let toPlacemark = toPlacemarks?.first,
                      let toLocation = toPlacemark.location else {
                    completion(nil)
                    return
                }

                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: fromLocation.coordinate))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: toLocation.coordinate))
                request.transportType = .automobile

                let directions = MKDirections(request: request)
                directions.calculate { response, _ in
                    guard let route = response?.routes.first else {
                        completion(nil)
                        return
                    }

                    let distanceInKm = route.distance / 1000.0
                    let estimatedBattery = max(0, 100 - Int((distanceInKm / 400.0) * 100))

                    completion(estimatedBattery)
                }
            }
        }
    }
}

#Preview {
    HomePage()
}

