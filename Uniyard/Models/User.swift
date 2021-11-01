
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct User: Identifiable, Codable{
  var id:String = UUID().uuidString
  var email:String
  var password:String
  var user_image:String
  var first_name:String
  var last_name:String
  var campus_location:String
  var saved_post_list:[String]
  var my_post_list:[String]
  var date_joined:Timestamp
  var suggestion_preference:String
  var user_status:Bool
  
  enum CodingKeys: String, CodingKey {
    case email
    case password
    case user_image
    case first_name
    case last_name
    case campus_location
    case saved_post_list
    case my_post_list
    case date_joined
    case suggestion_preference
    case user_status
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
  
}
