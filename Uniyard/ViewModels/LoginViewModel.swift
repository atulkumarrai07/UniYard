
import Foundation
import Combine
import FirebaseAuth

class LoginModel: ObservableObject {
	@Published var email = ""
	@Published var password = ""
	@Published var isEmailValid = false
	@Published var isPasswordValid = false
	@Published var canSubmit = false
	@Published var signedIn = false
  @Published var alert = false
  @Published var error = ""
	
	var auth = Auth.auth()
	
	var isLoggedIn:Bool{
		return auth.currentUser != nil
	}
	
	private var cancellableSet: Set<AnyCancellable> = []
	
	let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*@andrew.cmu.edu$")
	let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
	
	init() {
		$email.map{email in
							 return self.emailPredicate.evaluate(with: email)
		}.assign(to: \.isEmailValid, on: self).store(in: &cancellableSet)
		
		$password.map{password in
							 return self.passwordPredicate.evaluate(with: password)
		}.assign(to: \.isPasswordValid, on: self).store(in: &cancellableSet)
		
		Publishers.CombineLatest($isEmailValid, $isPasswordValid).map{isEmailValid, isPasswordValid in return (isEmailValid && isPasswordValid)}.assign(to: \.canSubmit, on: self).store(in: &cancellableSet)
	}
	
	var emailPrompt:String{
		(isEmailValid || email.isEmpty) ? "":"Email Address entered does not satisfy basic requirements"
	}
	
	var passwordPrompt:String{
		(isPasswordValid || password.isEmpty) ? "":"Password entered does not satisfy basic requirements"
	}
	
	func login(email:String, password:String) {
		auth.signIn(withEmail: email, password: password) { [weak self] result, error in
      if(error != nil){
        self?.error = error!.localizedDescription
        self?.alert.toggle()
      }
			guard result != nil, error == nil else{
				return
			}
			//Success
			DispatchQueue.main.async {
				self?.signedIn = true
			}
		}
	}
	
	func signOut() {
		try? auth.signOut()
		self.signedIn = false
		self.email = ""
		self.password = ""
	}
	
}



