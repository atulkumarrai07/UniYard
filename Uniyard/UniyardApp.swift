

import SwiftUI
import Firebase

@main
struct UniyardApp: App {
  init() {
    FirebaseApp.configure()
  }
    var body: some Scene {
//      let loginModel = LoginModel()
        WindowGroup {
					CreateBuyView()
          
//          Login()
//          SignUpView()
        }
    }
}
