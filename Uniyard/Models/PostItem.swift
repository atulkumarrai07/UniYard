import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PostItem:ObservableObject {
	
	@Published var postId:String
	@Published var last_modified_timestamp:Date
	@Published var Availability:String
	@Published var post_creation_date:Date
	@Published var itemId:String
	@Published var item_title:String
	@Published var item_description:String
	@Published var item_category:String
	@Published var item_buy:Bool
	@Published var condition:String
	@Published var price:Double
	@Published var images:[String]
	@Published var zip_code:String
	@Published var delivery:Bool
	@Published var pickup_location:String
	@Published var isSaved:Bool
  
	init(postId:String, last_modified_timestamp:Date, Availability:String, post_creation_date:Date, itemId:String, item_title:String, item_description:String, item_category:String, item_buy:Bool, condition:String, price:Double, images:[String], zip_code:String, delivery:Bool, pickup_location:String, isSaved:Bool) {
		self.postId = postId
		self.last_modified_timestamp = last_modified_timestamp
		self.Availability = Availability
		self.post_creation_date = post_creation_date
		self.itemId = itemId
		self.item_title = item_title
		self.item_description = item_description
		self.item_category = item_category
		self.item_buy = item_buy
		self.condition = condition
		self.price = price
		self.images = images
		self.zip_code = zip_code
		self.delivery = delivery
		self.pickup_location = pickup_location
		self.isSaved = isSaved
	}
}
