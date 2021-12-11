
import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct Login: View {
  @StateObject var loginModel: LoginModel
    var body: some View {
      NavigationView{
        ZStack(alignment: .center){
          ZStack{
            VStack{
              Image("white_login_logo").resizable().scaledToFit().padding(.bottom,15)
              
              Text("Welcome!").font(.custom("Comfortaa", size: 35)).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).fontWeight(.semibold).padding(.bottom,10)
              
              EntryField(sfSymbol: "envelope", placeHolder: "Email Address", prompt: loginModel.emailPrompt, field: $loginModel.email)
              
              EntryField(sfSymbol: "lock", placeHolder: "Password", prompt: loginModel.passwordPrompt, field: $loginModel.password)
              
              Button(action: {
                loginModel.login(email: loginModel.email, password: loginModel.password)
              }, label: {
                Text("Login").foregroundColor(.white)
              }).padding(.horizontal,90).padding(.vertical).background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).cornerRadius(15.0).opacity(loginModel.canSubmit ? 1 : 0.6).disabled(!loginModel.canSubmit)
              
              Button(action: {
                self.reset()
              }, label: {
                Text("Forgot Password?").font(.system(size: 15)).padding().foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
              }).padding(.horizontal,90).padding(.vertical).background(Color.white)
              
//              NavigationLink(
//                destination: ForgotPassword(),
//                label: {
//                  Text("Forgot Password?").font(.system(size: 15)).padding().foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
//                })
              NavigationLink("New User?", destination: SignUpView(loginModel: loginModel)).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding(.horizontal,60).padding(.vertical).overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
              
              Spacer()
              
              Text("UniYard © 2021").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.custom("Comfortaa", size: 12)).padding(.bottom,2).padding(.top,30)
            }.padding().navigationTitle("Login").navigationBarHidden(true)
          }
          if (loginModel.alert){
            ErrorView(loginModel: loginModel)
          }
        }
      }
    }
  
  func reset() {
    if(loginModel.email != ""){
      loginModel.auth.sendPasswordReset(withEmail: loginModel.email){err in
        if err != nil{
          loginModel.error = err!.localizedDescription
          loginModel.alert.toggle()
          return
        }
        loginModel.error = "RESET"
        loginModel.alert.toggle()
      }
    }
    else{
      loginModel.error = "Email id is empty"
      loginModel.alert.toggle()
    }
  }
}

struct ErrorView: View {
  @StateObject var loginModel:LoginModel
  var body: some View{
    GeometryReader{_ in
      VStack{
        HStack{
          Text(loginModel.error == "RESET" ? "Message" : "Error")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          
          Spacer()
        }
        .padding(.horizontal,25)
        Text(loginModel.error == "RESET" ? "Password reset link has been sent successfully" : loginModel.error)
          .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          .padding(.top)
          .padding(.horizontal, 25)
        Button(action: {
          loginModel.alert.toggle()
        }){
          Text(loginModel.error == "RESET" ? "Ok" : "Cancel")
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 120)
            .background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        }
//        .background(Color("Color"))
        .cornerRadius(10)
        .padding(.top, 25)
      }
      .padding(.vertical, 25)
      .frame(width: UIScreen.main.bounds.width - 70)
      .background(Color.white)
      .cornerRadius(15)
    }
    .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
  }
}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//      let loginModel:LoginModel = LoginModel()
//      Login(loginModel: loginModel)
//    }
//}

struct Error_Preview: PreviewProvider{
  static var previews: some View {
    let loginModel:LoginModel = LoginModel()
    ErrorView(loginModel: loginModel)
  }
}



 

