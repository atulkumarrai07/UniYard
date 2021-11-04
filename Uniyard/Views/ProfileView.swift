import SwiftUI
struct ProfileView: View {
  @EnvironmentObject var loginModel:LoginModel
 var body: some View {
    VStack{
    HStack {
       Text("Profile")
       .font(.largeTitle)
       .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
       .fontWeight(.heavy)
       .frame(maxWidth: .infinity, alignment: .center)
    }
     Text("This is the profile view").bold()
      HStack{
        Button("Logout", action: {
          loginModel.signOut()
        })
      }
     Spacer()
    }.navigationBarHidden(true)
 }
}
struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
