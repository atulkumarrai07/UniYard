import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class CurUserViewModel: ObservableObject {
	private let database = Firestore.firestore()
	
	@Published var user_id = ""
	@Published var email = ""
	@Published var password = ""
	@Published var user_image = ""
	@Published var first_name = ""
	@Published var last_name = ""
	@Published var campus_location = ""
	@Published var date_joined = Timestamp.init()
	@Published var notification_preference = true
	@Published var user_status = true
	
	init() {
		getUserDetails()
	}
	
	func getUserDetails(){
			let auth = Auth.auth()
			let user_id = auth.currentUser?.uid
			let userRef = database.collection("Users").document(user_id!)
			
			userRef.getDocument { (document, error) in
				if let err = error {
					print(err.localizedDescription)
				}
				else{
					self.user_id = user_id ?? ""
					self.email = document?.get("email") as? String ?? ""
					self.password = document?.get("password") as? String ?? ""
					self.first_name = document?.get("first_name") as? String ?? ""
					self.last_name = document?.get("last_name") as? String ?? ""
					self.user_image = document?.get("user_image") as? String ?? ""
					self.campus_location = document?.get("campus_location") as? String ?? ""
					self.date_joined = document?.get("date_joined") as? Timestamp ?? Timestamp.init()
					self.notification_preference = document?.get("suggestion_preference") as? Bool ?? true
					self.user_status = document?.get("user_status") as? Bool ?? true
				}
      }
	}
	
	func updatePwd(_ newPwd: String){
		let auth = Auth.auth()
		let user_id = auth.currentUser?.uid
    auth.currentUser?.updatePassword(to: newPwd) { error in
      let userRef = self.database.collection("Users").document(user_id!)
      userRef.getDocument { (document, err) in
        if let err = err {
          print(err.localizedDescription)
        }
        else {
          document?.reference.updateData(["password": newPwd])
        }
      }
    }
	}
	
	func updateLocation(_ newLocation: String){
		let auth = Auth.auth()
		let user_id = auth.currentUser?.uid
		let userRef = database.collection("Users").document(user_id!)
		userRef.getDocument { (document, err) in
			if let err = err {
				print(err.localizedDescription)
			}
			else {
				document?.reference.updateData(["campus_location": newLocation])
			}
		}
	}
	
	func updateUserImage(_ newImage: String){
		let auth = Auth.auth()
		let user_id = auth.currentUser?.uid
		let userRef = database.collection("Users").document(user_id!)
		userRef.getDocument { (document, err) in
			if let err = err {
				print(err.localizedDescription)
			}
			else {
				document?.reference.updateData(["user_image": newImage])
			}
		}
	}
	
	func updateNotification(_ newNotification: Bool){
		let auth = Auth.auth()
		let user_id = auth.currentUser?.uid
		let userRef = database.collection("Users").document(user_id!)
		userRef.getDocument { (document, err) in
			if let err = err {
				print(err.localizedDescription)
			}
			else {
				document?.reference.updateData(["suggestion_preference": newNotification])
			}
		}
	}
	
	
	
	
	
}
