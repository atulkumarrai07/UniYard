import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//struct Message: Identifiable, Codable {
//  var id:String = UUID().uuidString
//  var post_id:String
//  var user_1:String
//  var user_2:String
//  var sequence:[String]
//
//  enum CodingKeys: String, CodingKey {
//    case post_id
//    case user_1
//    case user_2
//    case sequence
//
//  }
//
//  var dictionary: [String: Any] {
//          let data = (try? JSONEncoder().encode(self)) ?? Data()
//          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
//  }
//}

struct Message: Identifiable {
  
  enum MessageType{
    case Sent, Received
  }
  
  let id = UUID().uuidString
  let date: Date
  let text: String
  let type: MessageType
  var hasUnreadMessage = false
  
  init(_ text: String, type: MessageType, date: Date) {
    self.date = date
    self.type = type
    self.text = text
  }
  
  init(_ text:String, type: MessageType) {
    self.init(text, type: type, date:Date())
  }
}
