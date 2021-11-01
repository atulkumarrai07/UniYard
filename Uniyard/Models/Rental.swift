import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Rental: Identifiable, Codable {
  var id:String = UUID().uuidString
  var post_id:String
  var inquiry_title:String
  var property_type:String
  var property_description:String
  var num_bed:Int
  var num_bath:Int
  var sqft:Int
  var max_rent:String
  var from_date:String
  var to_date:String
  var washer_dryer:Bool
  var pet_friendly:Bool
  var rent_amount:Double
  var rent_currency:Double
  var amenities:[String]
  var images:[String]
  var location:String
  

  enum CodingKeys: String, CodingKey {
    case post_id
    case inquiry_title
    case property_type
    case property_description
    case num_bed
    case num_bath
    case sqft
    case max_rent
    case from_date
    case to_date
    case washer_dryer
    case pet_friendly
    case rent_amount
    case rent_currency
    case amenities
    case images
    case location
      
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
}
