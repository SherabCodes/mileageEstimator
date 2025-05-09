import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            ProfilePage()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            PowerBatteryView()
                            .tabItem {
                                Image(systemName: "power")
                                Text("Power&Battery")
                            }
            MapPage()
                .tabItem {
                    Image(systemName: "map")
                    Text("MapView")
                }
            
            
                
            
        }
    }
}
