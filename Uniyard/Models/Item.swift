import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Item: Identifiable, Codable {
  var id:String = UUID().uuidString
  var post_id:String
  var item_title:String
  var item_description:String
  var item_category:String
  var item_buy:Bool
  var condition:String
  var price:Double
  var images:[String]
  var zip_code:String
  var delivery:Bool
  var pickup_location:String

  enum CodingKeys: String, CodingKey {
    case post_id
    case item_title
    case item_description
    case item_category
    case item_buy
    case condition
    case price
    case images
    case zip_code
    case delivery
    case pickup_location
      
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}

