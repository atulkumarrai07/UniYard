import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Notification: Identifiable, Codable {
  var id:String = UUID().uuidString
  var user_id:String
  var notification_on: Bool
  var saved_post_change_alert: Bool
  var sequence:[String]
  
  enum CodingKeys: String, CodingKey {
    case user_id
    case notification_on
    case saved_post_change_alert
    case sequence
    
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}
