

import SwiftUI

struct UniYardHomepage: View {
  @EnvironmentObject var loginModel:LoginModel
    var body: some View {
      NavigationView{
          VStack{
            Text("UniYard Homepage")
            
            HStack{
              Button("Logout", action: {
                loginModel.signOut()
              })
            }
            
            HStack{
              NavigationLink("Items", destination: ItemsHome(userId: "U00001")).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).frame(width: 150, height: 100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center).overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
            }
          }
        
      }
    }
}

struct UniYardHomepage_Previews: PreviewProvider {
    static var previews: some View {
        UniYardHomepage()
    }
}
