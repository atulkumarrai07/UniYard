import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
  var id:String = UUID().uuidString
  var post_id:String
  var user_1:String
  var user_2:String
  var sequence:[String]
  
  enum CodingKeys: String, CodingKey {
    case post_id
    case user_1
    case user_2
    case sequence
    
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}
