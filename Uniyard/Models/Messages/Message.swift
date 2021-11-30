import Foundation
import FirebaseFirestore
//import FirebaseFirestoreSwift 

struct Message: Codable, Identifiable, Hashable {
  
  enum MessageType: Int, Codable{
    case Sent, Received
  }
    
  var id = UUID().uuidString
  var date: Date
  var from_user_id: String
  var text: String
  var type: MessageType
  
  enum CodingKeys: String, CodingKey{
    case date
    case from_user_id
    case text
    case type
  }
  
//  init(_ text: String, type: MessageType, date: Date, from_user_id:String) {
//    self.date = date
//    self.type = type
//    self.text = text
//    self.from_user_id = from_user_id
//  }
//
//  init(_ text:String, type: MessageType, from_user_id:String) {
//    self.init(text, type: type, date:Date(), from_user_id: from_user_id)
//  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }

}
