import SwiftUI

struct ContentView: View {
    // Dummy location list
    let locations = ["New York", "Los Angeles", "Chicago", "San Francisco", "Seattle"]

    @State private var selectedStart = "New York"
    @State private var selectedDestination = "Los Angeles"
    @State private var batteryCoverage = 90 // Replace with dynamic value later

    var body: some View {
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

            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

