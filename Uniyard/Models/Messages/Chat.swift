import Foundation
import FirebaseFirestore

struct Chat: Codable, Identifiable, Hashable{
  var id = UUID().uuidString
//  var post_id:String
  var user1:MessageUser
  var user2:MessageUser
  var messages:[Message]
  var hasUnreadMessage = false
  
  enum CodingKeys: String, CodingKey {
//    case post_id
    case user1
    case user2
    case messages
    case hasUnreadMessage
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
  
}




