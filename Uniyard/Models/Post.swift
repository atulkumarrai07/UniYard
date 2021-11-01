
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
  var id:String = UUID().uuidString
  var last_modified_timestamp:Timestamp
  var Availability:String
  var post_creation_date:Timestamp
  
  enum CodingKeys: String, CodingKey {
    case last_modified_timestamp
    case Availability
    case post_creation_date
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}

