import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Notification_Sequence: Identifiable, Codable {
  var id:String = UUID().uuidString
  var post_id:String
  var timestamp_notf:Timestamp
  var content:String
  
  enum CodingKeys: String, CodingKey {
    case post_id
    case timestamp_notf
    case content
    
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}
