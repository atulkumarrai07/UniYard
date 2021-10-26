//
//  SwiftUIView.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/25/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State var cmu_email=""
  let emailPred = NSPredicate(format: "SELF MATCHES %@", "^.*@andrew.cmu.edu$")
  let pwdPred = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
    @State var first_name=""
    @State var last_name=""
    @State var password=""
    @State var confirm_password=""
    @State private var showingAlert = false
    @State var isValidEmail = false
    @State var isFirstNameEmpty = false
    @State var isPwdMatching = false
    @State var isPasswordValid = false

  
    var body: some View {
      VStack{
        Text("Sign Up")
          .font(.largeTitle)
          .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          .fontWeight(.heavy)
          .frame(maxWidth: .infinity, alignment: .center)
          .padding(.top, 25)
        // Spacer(minLength: 0)
          ScrollView{
            Group{
             Text("CMU Email")
              .font(.headline)
              .foregroundColor(.black)
              .fontWeight(.semibold)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.horizontal)
        
      
      //Spacer()
        
              TextField("Email address", text: $cmu_email)
              
        .padding(.horizontal)
        .frame(alignment: .leading)
        .background(Color.white)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
//                .onChange(of: cmu_email , perform: { value in
//                  if !value.isEmpty && emailPred.evaluate(with: value)
//                  {
//                    isValidEmail = false
//                  }
//                  else{
//                    isValidEmail = true
//                  }
//                })
        
        Divider()
          .padding(.horizontal, 15)
//          .padding(.bottom)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
      if !cmu_email.isEmpty && !emailPred.evaluate(with: cmu_email) {
        HStack()
        {
        Text("Invalid email address")
          .font(.caption)
          .foregroundColor(.red)
          .transition(AnyTransition.opacity.animation(.easeIn))
          Spacer()
        }.padding(.horizontal)
        }
        
        Text("First Name")
         .font(.headline)
         .foregroundColor(.black)
         .fontWeight(.semibold)
         .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
      
        TextField("First name", text: $first_name)
        .padding(.horizontal)
        .frame(alignment: .leading)
        .background(Color.white)
          .onChange(of: first_name, perform: { value in
            if first_name.isEmpty
            {
              isFirstNameEmpty = true
            }
            else
            {
              isFirstNameEmpty = false
            }
          })
            
        Divider()
          .padding(.horizontal, 15)
          .padding(.bottom)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        if isFirstNameEmpty {
          HStack()
          {
          Text("First Name field cannot be empty")
            .font(.caption)
            .foregroundColor(.red)
            .transition(AnyTransition.opacity.animation(.easeIn))
            Spacer()
          }.padding(.horizontal)
          }
            }
            
        Group {
        Text("Last Name")
         .font(.headline)
         .foregroundColor(.black)
         .fontWeight(.semibold)
         .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        TextField("Last name", text: $last_name)
        .padding(.horizontal)
        .frame(alignment: .leading)
        .background(Color.white)
         
        Divider()
          .padding(.horizontal, 15)
          .padding(.bottom)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
           
        
        Text("Campus Location")
         .font(.headline)
         .foregroundColor(.black)
         .fontWeight(.semibold)
         .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
          
          campusDropDown().padding(.leading, -195)
        
        Text("Password")
         .font(.headline)
         .foregroundColor(.black)
         .fontWeight(.semibold)
         .frame(maxWidth: .infinity, alignment: .leading)
         .padding(.horizontal)
          
          SecureInputView("Password", text: $password)
          .padding(.horizontal)
          .frame(alignment: .leading)
          .background(Color.white)
          .autocapitalization(.none)
            .onChange(of: password, perform: { value in
              if !pwdPred.evaluate(with: password) {
                isPasswordValid = false
              }
              else
              {
                isPasswordValid = true
              }
            })
          Divider()
            .padding(.horizontal, 15)
         //   .padding(.bottom)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
  
          if !password.isEmpty && isPasswordValid == false{
            HStack()
            {
            Text("Password must be 8-15 chars,must include at least one upper case, one lower case letter, and one number")
              .font(.caption)
              .foregroundColor(.red)
              .transition(AnyTransition.opacity.animation(.easeIn))
              Spacer()
            }.padding(.horizontal)
            }
            }
        Group {
        Text("Confirm Password")
         .font(.headline)
         .foregroundColor(.black)
         .fontWeight(.semibold)
         .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
          SecureInputView("Confirm Password", text: $confirm_password)
          .padding(.horizontal)
          .frame(alignment: .leading)
          .background(Color.white)
          .autocapitalization(.none)
                    .onChange(of: confirm_password , perform: { value in
                      if confirm_password == password
                      {
                        isPwdMatching = true
                      }
                      else{
                        isPwdMatching = false
                      }
                    })
//            .foregroundColor(isPwdMatching ? Color(.black): .red)
          Divider()
            .padding(.horizontal, 15)
          //  .padding(.bottom)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)

          
          if !confirm_password.isEmpty && !isPwdMatching {
            HStack()
            {
            Text("Passwords do not match")
              .font(.caption)
              .foregroundColor(.red)
              .transition(AnyTransition.opacity.animation(.easeIn))
              Spacer()
            }.padding(.horizontal)
            }
        
        }
          
          HStack{
            CheckView(title: "By creating an account, you agree to our Terms & Conditions")
          }
          .font(.subheadline)
          .foregroundColor(.black)
          .frame(width: 340, height: 70, alignment: .leading)
          
          
            Button(action: {
              showingAlert = true
            }, label: {
          Text("Register")
            })
            .alert(isPresented:$showingAlert) {
              Alert(
              title: Text("You have been successfully registered with UniYard!"),
              message: Text("Do you wish to login now?"),
              primaryButton: .destructive(Text("Yes")) {
                  print("Take to login page...")
              },
              secondaryButton: .cancel()
          )
      }
//        .disabled(cmu_email.isEmpty || first_name.isEmpty || last_name.isEmpty
//                        || password.isEmpty || confirm_password.isEmpty)
//            .opacity(signUpPage.isSignUpComplete ? 1 : 0.6)
            .font(.title)
            .disabled(!isValidEmail && !isPwdMatching && !isFirstNameEmpty && !isPasswordValid)
        .foregroundColor(.white)
        .padding(.vertical, 10)
        .padding(.horizontal, 50)
        .background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        .cornerRadius(15)
    }
  }
}
}


struct CheckView: View {
    @State var isChecked:Bool = false
    var title:String
    func toggle(){
      isChecked = !isChecked
    }
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
             
            }

        }.onChange(of: isChecked, perform: { value in
          if(!isChecked)
          {
            Alert(
            title: Text("Important!"),
            message: Text("Kindly check the T&C to register with us"),
              
              primaryButton: .default(Text("Yes")) ,
              secondaryButton: .destructive(Text("No")) {
                  print("User selected no...")
              }
            )
          }
        })
    }
}

struct campusDropDown: View {
  @State var expand = false
  @State var selectedOption = "Select Location..."
  var body: some View{
    VStack(alignment: .leading){
      HStack{
        Text("\(selectedOption)")
          .fontWeight(.semibold)
          .foregroundColor(.gray)
          .frame(alignment: .leading)
        Image(systemName: expand ? "chevron.up": "chevron.down")
          .resizable()
          .frame(width: 13, height: 6, alignment: .leading)
          .foregroundColor(.black)
          .frame(alignment: .leading)
      }.onTapGesture {
        self.expand.toggle()
      }
      if(expand){
        Button(action: {
          print("Pittsburgh")
          self.selectedOption = "Pittsburgh"
          self.expand.toggle()
        }){
          Text("Pittsburgh")
            .padding(10)
        }.foregroundColor(.black)
        Button(action: {
          print("Australia")
          self.selectedOption = "Australia"
          self.expand.toggle()
        }){
          Text("Australia")
            .padding(10)
        }.foregroundColor(.black)
        Button(action: {
          print("Qatar")
          self.selectedOption = "Qatar"
          self.expand.toggle()
        }){
          Text("Qatar")
            .padding(10)
        }.foregroundColor(.black)
        Button(action: {
          print("Africa")
          self.selectedOption = "Africa"
          self.expand.toggle()
        }){
          Text("Africa")
            .padding(10)
        }.foregroundColor(.black)
      }
    }.padding()
    .cornerRadius(15)
    //    .shadow(color: .gray, radius: 5)
    .animation(.spring())
  }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
      SignUpView()
    }
}

