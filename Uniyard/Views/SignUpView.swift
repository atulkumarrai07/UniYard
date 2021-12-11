//
//  SwiftUIView.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/25/21.
//

import SwiftUI

struct SignUpView: View {
    var loginModel:LoginModel
	
    @Environment(\.presentationMode) var signUpPresentation: Binding<PresentationMode>
    @StateObject var signupvmodel = SignUpViewModel()
    var body: some View {
      ZStack{
        ZStack{
          VStack{
            NavigationLink(
              destination: Login(loginModel: loginModel),
              isActive: $signupvmodel.displayLogin,
              label: {
                Text("")
              })
            HStack {
                 Button(action: {
                  self.signUpPresentation.wrappedValue.dismiss()
                 }){
                  Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                 }
                 Text("Sign Up")
                  .font(.largeTitle)
                  .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                  .fontWeight(.heavy)
                  .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
                }.padding()
             
              ScrollView{
                Group{
                 Text("CMU Email")
                  .font(.headline)
                  .foregroundColor(.black)
                  .fontWeight(.semibold)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.horizontal)
                  EntryFieldSignUp(placeHolder: "Email address", prompt: signupvmodel.emailPrompt, field: $signupvmodel.cmu_email)
                    .keyboardType(.emailAddress)
                  
                  Spacer()
                  
                  Text("First Name")
                   .font(.headline)
                   .foregroundColor(.black)
                   .fontWeight(.semibold)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)
                  EntryFieldSignUp(placeHolder: "First Name", prompt: signupvmodel.firstNamePrompt, field: $signupvmodel.first_name)
                  
                  Spacer()
                  
                  Text("Last Name")
                   .font(.headline)
                   .foregroundColor(.black)
                   .fontWeight(.semibold)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)
                  EntryFieldSignUp(placeHolder: "Last Name", prompt: signupvmodel.lastNamePrompt, field: $signupvmodel.last_name)
                  
                 Spacer()
                  
                }
                Group
                {
                 
                  Text("Campus Location")
                   .font(.headline)
                   .foregroundColor(.black)
                   .fontWeight(.semibold)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)
          
                    CampusLocationPicker().padding(.leading, -195)
                  
                  
                  Text("Password")
                   .font(.headline)
                   .foregroundColor(.black)
                   .fontWeight(.semibold)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)
                  
                  SecureInputViewSignUp("Password", prompt:signupvmodel.passwordPrompt, text: $signupvmodel.password)
                  Spacer()
                  
                  Text("Confirm Password")
                   .font(.headline)
                   .foregroundColor(.black)
                   .fontWeight(.semibold)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.horizontal)
                  SecureInputViewSignUp("Confirm Password", prompt: signupvmodel.confirmPwdPrompt, text: $signupvmodel.confirm_password)
                }
                Group{
                  HStack{
                    Button(action: signupvmodel.toggled){
                        HStack{
                          Image(systemName: signupvmodel.showTCSelector ? "checkmark.square": "square")
                            Text("By checking the box, you agree to the Terms & Conditions")
                              .font(.caption)
                              .foregroundColor(.black)
                              .frame(width: 330, height: 20, alignment: .leading)
                            }
                          }
                        }
                  Text(signupvmodel.TCPrompt)
                          .font(.caption)
                          .foregroundColor(.red)
                          .transition(AnyTransition.opacity.animation(.easeIn))
                    .padding(.horizontal, -180)
                  Button(action: {
                    signupvmodel.signUp(email: signupvmodel.cmu_email, password: signupvmodel.password)
                  }
                         , label: {
                      Text("Register")
                        })
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 50)
                    .background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                    .cornerRadius(15)
                    .opacity(signupvmodel.canSignUp ? 1 : 0.6)
                    .disabled(!signupvmodel.canSignUp)
                    .alert(isPresented:$signupvmodel.registrationStatus) {
                         Alert(
                         title: Text("You have been successfully registered with UniYard!"),
                         message: Text("Do you wish to login?"),
                         primaryButton: .default(Text("Yes")) {
                          signupvmodel.displayLogin = true
                         },
                          secondaryButton: .cancel()
                       )
                     }
                }
              }
          }.navigationBarHidden(true)
        }
        if (signupvmodel.alert){
          ErrorViewSignUp(signupvmodel: signupvmodel)
        }
      }
      
      }
  }

struct ErrorViewSignUp: View {
  @StateObject var signupvmodel:SignUpViewModel
  var body: some View{
    GeometryReader{_ in
      VStack{
        HStack{
          Text("Error")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          
          Spacer()
        }
        .padding(.horizontal,25)
        Text(signupvmodel.error)
          .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          .padding(.top)
          .padding(.horizontal, 25)
        Button(action: {
          signupvmodel.alert.toggle()
        }){
          Text("Cancel")
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
      let loginModel = LoginModel()
      SignUpView(loginModel: loginModel)
      
    }
}

