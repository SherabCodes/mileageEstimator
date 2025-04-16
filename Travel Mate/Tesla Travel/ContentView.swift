import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    
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
            
            
            //Bottom Tab
                //selectedTap allows to swipe between screens
                TabView (selection: $selectedTab){
                    TabView {
                        NavigationView{
                            VStack{
                                Text("Station")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            }
                            .navigationTitle("StationView")
                        }
                        .tag(0)
                        .tabItem{
                            Text("Find my Station")
                        }
                        
                        VStack{
                            Text("HomeView")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }
                        .tag(1)
                        .tabItem{
                            Text("Home")
                        }
                        VStack{
                            Text("My Profile")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }
                        .tag(2)
                        .tabItem{
                            Text("Profile")
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            selectedTab = 0
                        }, label: {
                            VStack{
                                Text("Find my Station")
                            }
                        })
                        Spacer()
                        Button(action: {
                            selectedTab = 1
                        }, label: {
                            VStack{
                                Text("Home")
                            }
                        })
                        Spacer()
                        Button(action: {
                            selectedTab = 2
                        }, label: {
                            VStack{
                                Text("Profile")
                            }
                        })
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color(UIColor.darkGray))
                    
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
            
        }
    }}
    

#Preview {
    ContentView()
}

