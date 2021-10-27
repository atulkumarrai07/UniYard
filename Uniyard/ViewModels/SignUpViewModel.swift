//
//  SignUpViewModel.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/25/21.
//

import SwiftUI
import Combine
import FirebaseAuth

class SignUpViewModel: ObservableObject {
  
  @Published var cmu_email = ""
  @Published var first_name = ""
  @Published var last_name = ""
  @Published var password = ""
  @Published var confirm_password = ""
  @Published var showingAlert = false
  @Published var campus_location = "Pittsburgh"
  @Published var showCampusSelector = false
  @Published var showTCSelector = false
  
  @Published var isValidEmail = false
  @Published var isFirstNameEmpty = false
  @Published var isLastNameEmpty = false
  @Published var isPasswordValid = false
  @Published var isPwdMatching = false
  @Published var isTCChecked = false
  @Published var canSignUp = false
  @Published var canSignUp2 = false
 private var cancellableSet: Set<AnyCancellable> = []
  
  let emailPred = NSPredicate(format: "SELF MATCHES %@", "^.*@andrew.cmu.edu$")
  let pwdPred = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
  var loginModel:LoginModel = LoginModel()
   var auth = Auth.auth()
   
  init() {
    $cmu_email
      .map { email in
        return self.emailPred.evaluate(with: email)
      }.assign(to: \.isValidEmail, on: self).store(in: &cancellableSet)
    
    $password.map{password in
               return self.pwdPred.evaluate(with: password)
    }.assign(to: \.isPasswordValid, on: self).store(in: &cancellableSet)
    
    $first_name.map{firstname in
      return self.first_name.isEmpty
    }.assign(to: \.isFirstNameEmpty, on: self).store(in: &cancellableSet)
    
    $last_name.map{lastname in
      return self.last_name.isEmpty
    }.assign(to: \.isLastNameEmpty, on: self).store(in: &cancellableSet)
    
    Publishers.CombineLatest($password,$confirm_password)
      .map { password, confirm_password in
        return password == confirm_password
      }.assign(to: \.isPwdMatching, on: self).store(in: &cancellableSet)
    
    $showTCSelector.map{password in
      return self.showTCSelector
    }.assign(to: \.isTCChecked, on: self).store(in: &cancellableSet)
    
    Publishers.CombineLatest4($isValidEmail, $isPasswordValid, $isFirstNameEmpty, $isLastNameEmpty).map{isValidEmail, isPasswordValid, isFirstNameEmpty, isLastNameEmpty in return (isValidEmail && isPasswordValid && isFirstNameEmpty && isLastNameEmpty)}.assign(to: \.canSignUp2, on: self).store(in: &cancellableSet)
    Publishers.CombineLatest3($canSignUp2, $isPwdMatching, $showTCSelector).map{canSignUp2, isPwdMatching, showTCSelector in return (canSignUp2 && isPwdMatching && showTCSelector)}.assign(to: \.canSignUp, on: self).store(in: &cancellableSet)
  //  print(canSignUp)
  }
  
  func passwordMatch() -> Bool{
    password == confirm_password
  }
  func signUp() {
    print("signup done")
  }
  
  func toggled(){
    self.showTCSelector = !self.showTCSelector
  }

  var emailPrompt:String{
    (isValidEmail || cmu_email.isEmpty) ? "":"Email Address entered does not satisfy basic requirements"
  }
  var firstNamePrompt: String {
    (!first_name.isEmpty) ? "" : "First name cannot be empty"
  }
  var lastNamePrompt: String {
    ( !last_name.isEmpty) ? "" : "Last name cannot be empty"
  }
  var passwordPrompt:String{
    (isPasswordValid || password.isEmpty) ? "":"Password must be 8-15 chars,must include at least 1 upper case,\n1 lower case letter, and 1 number"
  }
  var confirmPwdPrompt: String {
    (passwordMatch() || confirm_password.isEmpty) ? "":"Both the passwords don't match"
  }
  var TCPrompt: String {
    (showTCSelector ? "":"T&C must be checked to register")
  }
  func signUp(email: String, password: String) {
   auth.createUser(withEmail: email, password: password) { [weak self]result, error in
    guard result != nil, error == nil else{
     return
    }
    //Success
    DispatchQueue.main.async {
     self?.loginModel.signedIn = true
    }
 //   if let id = result?.user.uid {
 //
 //   }
 //   else{
 //    return
 //   }
   }
  }
}

