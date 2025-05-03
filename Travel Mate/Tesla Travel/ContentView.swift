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
        }
    }
}