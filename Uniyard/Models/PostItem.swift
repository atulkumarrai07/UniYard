import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct PostItem {
  var postId:String
  var last_modified_timestamp:Timestamp
  var Availability:String
  var post_creation_date:Timestamp
  var itemId:String
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
}
