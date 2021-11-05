import Foundation
import FirebaseFirestore

struct Chat: Identifiable{
  var id:String = UUID().uuidString
  var post_id:String
  var user:User
//  var user_2:User
  var messages:[Message]
  
  enum CodingKeys: String, CodingKey {
    case post_id
    case user_1
//    case user_2
    case messages
  }
  
}
