import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            Form {
                
                // user information
                Section(header: Text("User Info")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("Elon Musk")
                                .font(.headline)
                            Text("elon.musk@example.com")
                                .font(.subheadline)
                            Text("29 Electric Ave, NY")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // vehicle details
                Section(header: Text("Vehicle Details")) {
                    HStack {
                        Text("Model")
                        Spacer()
                        Text("Tesla Model 3")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Battery Capacity")
                        Spacer()
                        Text("75 kWh")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Range")
                        Spacer()
                        Text("310 miles")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Charging Port")
                        Spacer()
                        Text("CCS")
                            .foregroundColor(.gray)
                    }
                }
                
                // payment info
                Section(header: Text("Payment Methods")) {
                    HStack {
                        Text("Visa **** 5592")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    Button("Add Payment Method") {
                        
                    }
                }
                
                // notif
                Section(header: Text("Notifications")) {
                    Toggle("Charging Complete", isOn: .constant(true))
                    Toggle("Low Battery", isOn: .constant(false))
                    Toggle("Nearby Charging Stations", isOn: .constant(true))
                }
                
                // additional security
                Section(header: Text("Security Settings")) {
                    NavigationLink(destination: Text("Change Password Page")) {
                        Text("Change Password")
                    }
                    Toggle("Two-Factor Authentication", isOn: .constant(true))
                }
                
                // settings
                Section(header: Text("Settings")) {
                    NavigationLink(destination: Text("Help Center")) {
                        Text("Help Center")
                    }
                    NavigationLink(destination: Text("Terms & Privacy")) {
                        Text("Terms & Privacy")
                    }
                    Button("Log Out", role: .destructive) {
                        // Handle logout
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
