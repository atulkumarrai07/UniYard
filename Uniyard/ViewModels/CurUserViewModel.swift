import Foundation
import FirebaseAuth
import FirebaseFirestore


class CurUserViewModel: ObservableObject {
	private let database = Firestore.firestore()
	
	@Published var email = ""
	@Published var password = ""
	@Published var user_image = ""
	@Published var first_name = ""
	@Published var last_name = ""
	@Published var campus_location = ""
	@Published var saved_post_list = []
	@Published var my_post_list = []
	@Published var date_joined = Timestamp.init()
	@Published var suggestion_preference = ""
	@Published var user_status = true
	@Published var notification_on = true
	
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
					self.email = document?.get("email") as? String ?? ""
					self.password = document?.get("password") as? String ?? ""
					self.first_name = document?.get("first_name") as? String ?? ""
					self.last_name = document?.get("last_name") as? String ?? ""
					self.user_image = document?.get("user_image") as? String ?? ""
					self.campus_location = document?.get("campus_location") as? String ?? ""
					self.saved_post_list = document?.get("saved_post_list") as? [String] ?? []
					self.my_post_list = document?.get("my_post_list") as? [String] ?? []
					self.date_joined = document?.get("date_joined") as? Timestamp ?? Timestamp.init()
					self.suggestion_preference = document?.get("suggestion_preference") as? String ?? ""
					self.user_status = document?.get("user_status") as? Bool ?? true
				}}
	}
	
	func updatePwd(_ newPwd: String){
		let auth = Auth.auth()
		let user_id = auth.currentUser?.uid
		let userRef = database.collection("Users").document(user_id!)
		userRef.getDocument { (document, err) in
			if let err = err {
				print(err.localizedDescription)
			}
			else {
				document?.reference.updateData(["password": newPwd])
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
	
	
	
}
