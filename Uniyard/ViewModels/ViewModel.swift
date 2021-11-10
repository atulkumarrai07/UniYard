
import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject
{
  private let database = Firestore.firestore()
  var users = [User]()
  var posts = [Post]()
  var items = [Item]()
  var rentals = [Rental]()
  var messages = [Message]()
  var message_sequences = [Message_Sequence]()
  var notifications = [Notification]()
  var notification_sequences = [Notification_Sequence]()
  var itemsWithPostsAvailable = [PostItem]()
  
	
  func addUser(user:User){
    
    database.collection("Users").document(user.id).setData(user.dictionary)
    
    //loading users in array
//    users.append(User(id: "U00001",email: "aaratric@andrew.cmu.edu", password: "aaratrika1234", user_image: "https://..jpg",first_name: "Aaratrika", last_name: "Chakraborty", campus_location: "Pittsburgh", saved_post_list: ["P00002","P00003"], my_post_list: ["P00001"], date_joined: Timestamp.init(), suggestion_preference: "Items", user_status: true))
//    users.append(User(id: "U00002",email: "atulkr@andrew.cmu.edu", password: "atul1234", user_image: "https://..jpg",first_name: "Atul", last_name: "Rai", campus_location: "Pittsburgh", saved_post_list: ["P00001","P00003"], my_post_list: ["P00002"], date_joined: Timestamp.init(), suggestion_preference: "Apartments", user_status: true))
//    users.append(User(id: "U00003",email: "mhao@andrew.cmu.edu", password: "mhao1234", user_image: "https://..jpg",first_name: "Iris", last_name: "Hao", campus_location: "Pittsburgh", saved_post_list: ["P00001","P00002","P00004"], my_post_list: ["P00003"], date_joined: Timestamp.init(), suggestion_preference: "Any", user_status: true))
//    users.append(User(id: "U00004",email: "johndoe@andrew.cmu.edu", password: "john1234", user_image: "https://..jpg", first_name: "John", last_name: "Doe", campus_location: "Pittsburgh", saved_post_list: ["P00002","P00003"], my_post_list: ["P00004"], date_joined: Timestamp.init(), suggestion_preference: "Any", user_status: true))
    
    //looping throught the array to push to the Firestore
//    for user in users{
//      database.collection("Users").document(user.id).setData(user.dictionary)
//    }
    
    // printing message on completion
    print("Sample users loaded")
  }
  
  func fetchUser() {
    print("fetching")
    database.collection("Users").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let email = document.get("email") as? String ?? ""
              let password = document.get("password") as? String ?? ""
              let user_image = document.get("user_image") as? String ?? ""
              let first_name = document.get("first_name") as? String ?? ""
              let last_name = document.get("last_name") as? String ?? ""
              let campus_location = document.get("campus_location") as? String ?? ""
              let saved_post_list = document.get("saved_post_list") as? [String] ?? []
              let my_post_list = document.get("my_post_list") as? [String] ?? []
              let date_joined = document.get("date_joined") as? Timestamp ?? Timestamp.init()
              let suggestion_preference = document.get("suggestion_preference") as? String ?? ""
              let user_status = document.get("user_status") as? Bool ?? true
              self.users.append(User(id: id, email: email, password: password, user_image: user_image,first_name: first_name, last_name: last_name, campus_location: campus_location, saved_post_list: saved_post_list, my_post_list: my_post_list, date_joined: date_joined, suggestion_preference: suggestion_preference, user_status: user_status))
//                print("\(document.documentID) => \(document.data())")
            }
          for user in self.users{
            print(user)
          }
          print("User printed")
        }
    }
    
  }
  
  // load post in Firestore
  func addPost_old() {
    posts.append(Post(id: "P00001", last_modified_timestamp: Timestamp.init(), Availability: "Available", post_creation_date: Timestamp.init()))
    posts.append(Post(id: "P00002", last_modified_timestamp: Timestamp.init(), Availability: "Available", post_creation_date: Timestamp.init()))
    posts.append(Post(id: "P00003", last_modified_timestamp: Timestamp.init(), Availability: "Available", post_creation_date: Timestamp.init()))
    posts.append(Post(id: "P00004", last_modified_timestamp: Timestamp.init(), Availability: "Available", post_creation_date: Timestamp.init()))
    for post in posts{
      database.collection("Posts").document(post.id).setData(post.dictionary)
    }
    print("Posts loaded")
  }
  
  func addPost(post:Post) {
    database.collection("Posts").document(post.id).setData(post.dictionary)
  }
  
  func addItem(item: Item) {
    database.collection("Items").document(item.id).setData(item.dictionary)
  }
  
  func addItem_old() {
    items.append(Item(id: "I00001", post_id: "P00001", item_title: "Lamp", item_description: "A lamp for the study table", item_category: "Electronics", item_buy: false, condition: "Almost new", price: 15.90, images: ["https://..jpg"], zip_code: "15213", delivery: true, pickup_location: "3229 Hardie Way"))
    items.append(Item(id: "I00002", post_id: "P00004", item_title: "Vacuum Cleaner", item_description: "1 year old vacuum cleaner with auto detection technology available at reasonable price.", item_category: "Cleaning-Appliance", item_buy: false, condition: "New", price: 19.00, images: ["https://..jpg"], zip_code: "15213", delivery: false, pickup_location: "123 Forbes Avenue, Pittburgh"))
    
    for item in items{
      database.collection("Items").document(item.id).setData(item.dictionary)
    }
    print("Items loaded")
  }
  
  func addRental() {
    rentals.append(Rental(id: "R00001", post_id: "P00002", inquiry_title: "Looking for 1 bed, 1 bath apartment at Shadyside", property_type: "Apartment", property_description: "Great Location and well connected. Message me for more details..", num_bed: 1, num_bath: 1, sqft: 0, max_rent: "$1200/month" ,from_date: "Dec 31, 2021", to_date: "March 31, 2022", washer_dryer: true, pet_friendly: true, rent_amount: 0, rent_currency: 0, amenities: ["Parking","Gym"], images: ["https://..jpg"], location: "15213"))
    rentals.append(Rental(id: "R00002", post_id: "P00003", inquiry_title: "Looking for 1 bed, 1 bath apartment at Shadyside", property_type: "Apartment", property_description: "Great Location and well connected. Message me for more details..", num_bed: 2, num_bath: 1, sqft: 1234, max_rent: "" ,from_date: "Dec 31, 2021", to_date: "March 31, 2022", washer_dryer: false, pet_friendly: false, rent_amount: 0, rent_currency: 0, amenities: ["Parking","Gym"], images: ["https://..jpg"], location: "123 Forbes Avenue,Pittsburgh"))
    
    for rental in rentals{
      database.collection("Rentals").document(rental.id).setData(rental.dictionary)
    }
    print("rentals loaded")
  }
  
//  func addMessage() {
//    messages.append(Message(id: "M00001", post_id: "P00001", user_1: "U00004", user_2: "U00001", sequence: ["MS00001","MS00002"]))
//
//    for message in messages{
//      database.collection("Messages").document(message.id).setData(message.dictionary)
//    }
//    print("messages loaded")
//  }
  
  func addMessage_Sequence() {
    message_sequences.append(Message_Sequence(id: "MS00001", from_id: "U00004", timestamp_msg: Timestamp.init(), content: "Hi Aaratrika", read_status: true))
    message_sequences.append(Message_Sequence(id: "MS00002", from_id: "U00001", timestamp_msg: Timestamp.init(), content: "Hi John", read_status: true))
    
    for message_sequence in message_sequences{
      database.collection("Message_Sequences").document(message_sequence.id).setData(message_sequence.dictionary)
    }
    print("message_sequences loaded")
  }
  
  func addNotification() {
    notifications.append(Notification(id: "N00001", user_id: "U00001", notification_on: true, saved_post_change_alert: true, sequence: ["NS00001"]))
    
    for notification in notifications{
      database.collection("Notifications").document(notification.id).setData(notification.dictionary)
    }
    print("message_sequences loaded")
  }
  
  func addNotification_Sequence() {
    notification_sequences.append(Notification_Sequence(id: "NS00001", post_id: "P00002", timestamp_notf: Timestamp.init(), content: "Price of the apartment changed"))
    
    for notification_sequence in notification_sequences{
      database.collection("Notification_Sequences").document(notification_sequence.id).setData(notification_sequence.dictionary)
    }
    print("notification_sequence loaded")
  }
  
  func fetchAllPost() {
    print("fetching posts")
    database.collection("Posts").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let last_modified_timestamp = document.get("last_modified_timestamp") as? Timestamp ?? Timestamp.init()
              let Availability = document.get("Availability") as? String ?? ""
              let post_creation_date = document.get("post_creation_date") as? Timestamp ?? Timestamp.init()
              
              self.posts.append(Post(id: id, last_modified_timestamp: last_modified_timestamp, Availability: Availability, post_creation_date: post_creation_date))
           }
          for post in self.posts{
            print(post)
          }
          print("Posts printed")
        }
    }
  }
  
  func fetchAllItem() {
    print("fetching items")
    database.collection("Items").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
            let id = document.documentID
            let post_id = document.get("post_id") as? String ?? ""
            let item_title = document.get("item_title") as? String ?? ""
            let item_description = document.get("item_description") as? String ?? ""
            let item_category = document.get("item_category") as? String ?? ""
            let item_buy = document.get("item_buy") as? Bool ?? false
            let condition = document.get("condition") as? String ?? ""
            let price = document.get("price") as? Double ?? 0
            let images = document.get("images") as? [String] ?? []
            let zip_code = document.get("zip_code") as? String ?? ""
            let delivery = document.get("delivery") as? Bool ?? false
            let pickup_location = document.get("pickup_location") as? String ?? ""
            
            self.items.append(Item(id: id, post_id: post_id, item_title: item_title, item_description: item_description, item_category: item_category, item_buy: item_buy, condition: condition, price: price, images: images, zip_code: zip_code, delivery: delivery, pickup_location: pickup_location))
//                print("\(document.documentID) => \(document.data())")
            }
              for item in self.items{
                print(item)
              }
            print("Items printed")
        }
    }
  }
  
  // using this function for fetching all items with their posts to render details in items listing
  func fetchAllItemsWithPostsAvailable(completion: @escaping ([PostItem])->Void) {
    database.collection("Items").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let post_id = document.get("post_id") as? String ?? ""
              let item_title = document.get("item_title") as? String ?? ""
              let item_description = document.get("item_description") as? String ?? ""
              let item_category = document.get("item_category") as? String ?? ""
              let item_buy = document.get("item_buy") as? Bool ?? false
              let condition = document.get("condition") as? String ?? ""
              let price = document.get("price") as? Double ?? 0
              let images = document.get("images") as? [String] ?? []
              let zip_code = document.get("zip_code") as? String ?? ""
              let delivery = document.get("delivery") as? Bool ?? false
              let pickup_location = document.get("pickup_location") as? String ?? ""
              self.fetchPostBasedOnPostId(postId: post_id) {(post) in
                if(post.Availability == "Available")
                {
                  self.itemsWithPostsAvailable.append(PostItem(postId: post_id, last_modified_timestamp: post.last_modified_timestamp, Availability: post.Availability, post_creation_date: post.post_creation_date, itemId: id, item_title: item_title, item_description: item_description, item_category: item_category, item_buy: item_buy, condition: condition, price: price, images: images, zip_code: zip_code, delivery: delivery, pickup_location: pickup_location))
                }
                completion(self.itemsWithPostsAvailable)
              }
              }
          
//            print("Position 2: " + String(self.itemsWithPostsAvailable.count))
//          for itemwithPosts in self.itemsWithPostsAvailable{
//            print(itemwithPosts)
//          }
//          print("Items with posts printed")
          }
      }
  }
  
  func fetchPostBasedOnPostId(postId:String ,completion: @escaping (Post)->Void)
  {
    self.database.collection("Posts").document(postId).getDocument() { (documentpost, error) in
          if let documentpost = documentpost, documentpost.exists {
            let last_modified_timestamp = documentpost.get("last_modified_timestamp") as? Timestamp ?? Timestamp.init()
            let availability = documentpost.get("Availability") as? String ?? ""
            let post_creation_date = documentpost.get("post_creation_date") as? Timestamp ?? Timestamp.init()
            let post = Post(id: postId, last_modified_timestamp: last_modified_timestamp, Availability: availability, post_creation_date: post_creation_date)
            completion(post)
          } else {
              print("Document does not exist")
        }
//                print("Position 1: " + String(self.itemsWithPostsAvailable.count))
      
      }
  }
  
  func fetchAllRental() {
    print("fetching rentals")
    database.collection("Rentals").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let post_id = document.get("post_id") as? String ?? ""
              let inquiry_title = document.get("inquiry_title") as? String ?? ""
              let property_type = document.get("property_type") as? String ?? ""
              let property_description = document.get("property_description") as? String ?? ""
              let num_bed = document.get("num_bed") as? Int ?? 0
              let num_bath = document.get("num_bath") as? Int ?? 0
              let sqft = document.get("sqft") as? Int ?? 0
              let max_rent = document.get("max_rent") as? String ?? ""
              let from_date = document.get("from_date") as? String ?? ""
              let to_date = document.get("to_date") as? String ?? ""
              let washer_dryer = document.get("washer_dryer") as? Bool ?? false
              let pet_friendly = document.get("pet_friendly") as? Bool ?? false
              let rent_amount = document.get("rent_amount") as? Double ?? 0
              let rent_currency = document.get("rent_currency") as? Double ?? 0
              let location = document.get("location") as? String ?? ""
              let amenities = document.get("images") as? [String] ?? []
              let images = document.get("images") as? [String] ?? []
              
              self.rentals.append(Rental(id: id, post_id: post_id, inquiry_title: inquiry_title, property_type: property_type, property_description: property_description, num_bed: num_bed, num_bath: num_bath, sqft: sqft, max_rent: max_rent, from_date: from_date, to_date: to_date, washer_dryer: washer_dryer, pet_friendly: pet_friendly, rent_amount: rent_amount, rent_currency: rent_currency, amenities: amenities, images: images, location: location))
//                print("\(document.documentID) => \(document.data())")
            }
          for rental in self.rentals{
            print(rental)
          }
        print("Rentals printed")
      }
    }
  }
  
//  func fetchAllMessage() {
//    print("fetching messages")
//    database.collection("Messages").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in querySnapshot!.documents {
//              let id = document.documentID
//              let post_id = document.get("post_id") as? String ?? ""
//              let user_1 = document.get("user_1") as? String ?? ""
//              let user_2 = document.get("user_2") as? String ?? ""
//              let sequence = document.get("sequence") as? [String] ?? []
//
//              self.messages.append(Message(id: id, post_id: post_id, user_1: user_1, user_2: user_2, sequence: sequence))
////                print("\(document.documentID) => \(document.data())")
//            }
//          for message in self.messages{
//            print(message)
//          }
//        print("Messages printed")
//        }
//    }
//  }
  
  func fetchAllMessage_Sequence() {
    print("fetching message sequences")
    database.collection("Message_Sequences").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let from_id = document.get("from_id") as? String ?? ""
              let timestamp_msg = document.get("timestamp_msg") as? Timestamp ?? Timestamp.init()
              let content = document.get("content") as? String ?? ""
              let read_status = document.get("read_status") as? Bool  ?? false
              
              self.message_sequences.append(Message_Sequence(id: id, from_id: from_id, timestamp_msg: timestamp_msg, content: content, read_status: read_status))
//                print("\(document.documentID) => \(document.data())")
            }
          for message in self.message_sequences{
            print(message)
          }
        print("Message Sequences printed")
        }
    }
  }
  
  func fetchAllNotification() {
    print("fetching notifications")
    database.collection("Notifications").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let user_id = document.get("user_id") as? String ?? ""
              let sequence = document.get("sequence") as? [String] ?? [""]
              let notification_on = document.get("notification_on") as? Bool  ?? false
              let saved_post_change_alert = document.get("saved_post_change_alert") as? Bool  ?? false
              
              self.notifications.append(Notification(id: id, user_id: user_id, notification_on: notification_on, saved_post_change_alert: saved_post_change_alert, sequence: sequence))
//                print("\(document.documentID) => \(document.data())")
            }
          for notification in self.notifications{
            print(notification)
          }
        print("Notifications printed")
        }
    }
  }
  
  func fetchAllNotification_Sequence() {
    print("fetching notification sequences")
    database.collection("Notification_Sequences").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
              let id = document.documentID
              let post_id = document.get("post_id") as? String ?? ""
              let timestamp_notf = document.get("timestamp_notf") as? Timestamp ?? Timestamp.init()
              let content = document.get("content") as? String ?? ""
              
              self.notification_sequences.append(Notification_Sequence(id: id, post_id: post_id, timestamp_notf: timestamp_notf, content: content))
//                print("\(document.documentID) => \(document.data())")
            }
          for notification in self.notification_sequences{
            print(notification)
          }
        print("Notification Sequences printed")
      }
    }
  }

  

}
