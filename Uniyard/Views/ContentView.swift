
import SwiftUI
import FirebaseFirestore

struct ContentView: View {
<<<<<<< HEAD
 var viewModel: ViewModel = ViewModel()
=======
  var viewModel: ViewModel = ViewModel()
>>>>>>> parent of adf11a2 (Merge branch 'atulUniyard' of https://github.com/atulkumarrai07/Uniyard into atulUniyard)
  @EnvironmentObject var loginModel: LoginModel
    var body: some View {
     // BottomBarNav()
        ItemDetailsSell()
//      NavigationView{
//        VStack{
//          if(loginModel.signedIn)
//          {
//            UniYardHomepage()
//              .environmentObject(loginModel)
//          }
//          else
//          {
//            Login(loginModel: loginModel)
////            UniYardHomepage()
//          }
//        }.navigationBarHidden(true)
//      }.onAppear{
//        loginModel.signedIn = loginModel.isLoggedIn
//      }
  //keep commented//
//      NavigationView{
//        Text("Hello, world!")
//            .padding()
//      }.onAppear(){
<<<<<<< HEAD
     //   self.viewModel.addUser()
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
//
=======
////        self.viewModel.addUser()
////        self.viewModel.addItem()
////        self.viewModel.addMessage()
////        self.viewModel.addMessage_Sequence()
////        self.viewModel.addPost()
////        self.viewModel.addRental()
////        self.viewModel.addNotification()
////        self.viewModel.addNotification_Sequence()
//
////        self.viewModel.fetchUser()
////        self.viewModel.fetchAllItem()
////        self.viewModel.fetchAllMessage()
////        self.viewModel.fetchAllMessage_Sequence()
////        self.viewModel.fetchAllPost()
////        self.viewModel.fetchAllRental()
////        self.viewModel.fetchAllNotification()
////        self.viewModel.fetchAllNotification_Sequence()
////        self.viewModel.fetchAllItemsWithPostsAvailable()
//        let itemvmodel = ItemsViewModel()
//        itemvmodel.loadItemswithPostsAvailable()
>>>>>>> parent of adf11a2 (Merge branch 'atulUniyard' of https://github.com/atulkumarrai07/Uniyard into atulUniyard)
//      }
      //keep commented//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
