
import SwiftUI
import Combine
import FirebaseFirestore
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
  @Published var registrationStatus:Bool = false
  @Published var displayLogin = false
  @Published var alert = false
  @Published var error = ""

 private var cancellableSet: Set<AnyCancellable> = []

  let emailPred = NSPredicate(format: "SELF MATCHES %@", "^.*@andrew.cmu.edu$")
  let pwdPred = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
  var loginModel:LoginModel = LoginModel()
  var auth = Auth.auth()
  let viewModel = ViewModel()

  init() {
    $cmu_email
      .map { email in
        return self.emailPred.evaluate(with: email)
      }.assign(to: \.isValidEmail, on: self).store(in: &cancellableSet)

    $password.map{password in
               return self.pwdPred.evaluate(with: password)
    }.assign(to: \.isPasswordValid, on: self).store(in: &cancellableSet)

    $first_name.map{firstname in
      return !self.first_name.isEmpty
    }.assign(to: \.isFirstNameEmpty, on: self).store(in: &cancellableSet)

    $last_name.map{lastname in
      return !self.last_name.isEmpty
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
  }

  func passwordMatch() -> Bool{
    password == confirm_password
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
    (isPasswordValid || password.isEmpty) ? "":"Password must be 8-15 chars,must include at least 1 upper \ncase, 1 lower case letter, and 1 number"
  }
  var confirmPwdPrompt: String {
    (passwordMatch() || confirm_password.isEmpty) ? "":"Both the passwords don't match"
  }
  var TCPrompt: String {
    (showTCSelector ? "":"T&C must be checked to register")
  }
  func signUp(email: String, password: String) {
    viewModel.checkUserExist(email: email){result in
      if(result){
        self.alert.toggle()
        self.error = "User already Exist"
      }
      else{
        self.auth.createUser(withEmail: email, password: password) { [weak self]result, error in
         guard result != nil, error == nil else{
           self?.registrationStatus = false
          return
         }
         if let id = result?.user.uid {
           let user = User(id: id, email: (self?.cmu_email)!, password: password, user_image: "", first_name: (self?.first_name)!, last_name: self?.last_name ?? "", campus_location: self!.campus_location, saved_post_list: [], my_post_list: [], date_joined: Date(), suggestion_preference: true, user_status: true)
           
           let viewModel = ViewModel()
           viewModel.addUser(user: user)
           self?.registrationStatus = true
           DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
             self?.loginModel.signOut()
           }
         }
         else{
           self?.registrationStatus = false
          return
         }
        }
      }
    }
  }
}
