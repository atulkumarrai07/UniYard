
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message_Sequence: Identifiable, Codable {
  var id:String = UUID().uuidString
  var from_id:String
  var timestamp_msg:Timestamp
  var content:String
  var read_status:Bool
  
  enum CodingKeys: String, CodingKey {
    case from_id
    case timestamp_msg
    case content
    case read_status
    
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}
