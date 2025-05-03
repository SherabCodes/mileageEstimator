import SwiftUI

struct ProfilePage: View {
    var body: some View {
        ZStack{
            Color.blue
            
            Image(systemName: "person")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
