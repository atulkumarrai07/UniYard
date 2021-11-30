
import Foundation
import FirebaseFirestore


extension Chat{
  static let sampleChat = [
    Chat(post_id: "NNeFiUnv3kbuy3h1FWTG", user: User(id: "U00001",email: "aaratric@andrew.cmu.edu", password: "aaratrika1234", user_image: "https://..jpg",first_name: "Aaratrika", last_name: "Chakraborty", campus_location: "Pittsburgh", saved_post_list: ["P00002","P00003"], my_post_list: ["P00001"], date_joined: Timestamp.init(), suggestion_preference: "Items", user_status: true), messages: [Message("Hey!, How are you doing?", type: .Sent),Message("I'm good. How are you?", type: .Received)])
  ]
}
