
import SwiftUI
import FirebaseFirestore

struct ContentView: View {
//  var viewModel: ViewModel = ViewModel()
  @EnvironmentObject var loginModel: LoginModel
    var body: some View {
      NavigationView{
        VStack{
          if(loginModel.signedIn)
          {
            UniYardHomepage()
          }
          else
          {
            Login()
//            UniYardHomepage()
          }
        }.navigationBarHidden(true)
      }.onAppear{
        loginModel.signedIn = loginModel.isLoggedIn
      }
      
//      NavigationView{
//        Text("Hello, world!")
//            .padding()
//      }.onAppear(){
//        self.viewModel.addUser()
//        self.viewModel.addItem()
//        self.viewModel.addMessage()
//        self.viewModel.addMessage_Sequence()
//        self.viewModel.addPost()
//        self.viewModel.addRental()
//        self.viewModel.addNotification()
//        self.viewModel.addNotification_Sequence()
//
//        self.viewModel.fetchUser()
//        self.viewModel.fetchAllItem()
//        self.viewModel.fetchAllMessage()
//        self.viewModel.fetchAllMessage_Sequence()
//        self.viewModel.fetchAllPost()
//        self.viewModel.fetchAllRental()
//        self.viewModel.fetchAllNotification()
//        self.viewModel.fetchAllNotification_Sequence()
////
//      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
