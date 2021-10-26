//
//  Login.swift
//  Uniyard
//
//  Created by Atul Kumar Rai on 10/25/21.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct Login: View {
  @StateObject var loginModel = LoginModel()
    var body: some View {
      
      VStack{
        Image("Login_logo").resizable().scaledToFit().padding(.bottom,15)
        
        Text("Welcome!").font(.custom("Comfortaa", size: 35)).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).fontWeight(.semibold).padding(.bottom,10)
        
        EntryField(sfSymbol: "envelope", placeHolder: "Email Address", prompt: loginModel.emailPrompt, field: $loginModel.email)
        
        EntryField(sfSymbol: "lock", placeHolder: "Password", prompt: loginModel.passwordPrompt, field: $loginModel.password)
        
        Button(action: {
          loginModel.login()
        }, label: {
          Text("Login").foregroundColor(.white)
        }).padding(.horizontal,90).padding(.vertical).background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).cornerRadius(15.0).opacity(loginModel.canSubmit ? 1 : 0.6).disabled(!loginModel.canSubmit)
        
        NavigationLink(
          destination: ForgotPassword(),
          label: {
            Text("Forgot Password?").font(.system(size: 15)).padding().foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          })
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
          Text("New User?").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        }).padding(.horizontal,60).padding(.vertical).overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
        
        Spacer()
        
        Text("UniYard © 2021").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.custom("Comfortaa", size: 12)).padding(.bottom,2).padding(.top,30)
      }.padding()
      
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}



 

