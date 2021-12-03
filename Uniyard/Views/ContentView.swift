
import SwiftUI
import FirebaseFirestore

struct ContentView: View {
  var viewModel: ViewModel = ViewModel()
  @EnvironmentObject var loginModel: LoginModel
    var body: some View {
      NavigationView{
        VStack{
          if(loginModel.signedIn)
          {
            BottomBarNav(selectedTab: 0)
              .environmentObject(loginModel)
          }
          else
          {
            Login(loginModel: loginModel)
//            UniYardHomepage()
          }
        }
        .navigationBarHidden(true)
      }.onAppear{
        loginModel.signedIn = loginModel.isLoggedIn
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
