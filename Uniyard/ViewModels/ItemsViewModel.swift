
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class ItemsViewModel: ObservableObject {
  var viewModel = ViewModel()
  private let database = Firestore.firestore()
  @Published var location:String = "Pittsburgh"
  @Published var showingLocations:Bool = false
  @Published var renderSell:Bool = false
  @Published var sellButtonForegroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
  @Published var sellButtonBackgroundColor = Color(.white)
  @Published var buyButtonForegroundColor = Color(.white)
  @Published var buyButtonBackgroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
  @Published var itemswithPostsAvailableArray:[PostItem] = []
  @Published var title = ""
  @Published var pickUpAddress = ""
  @Published var price = ""
  @Published var budget = ""
  @Published var delivertRequest = false
  @Published var zipCode = ""
  @Published var description = ""
  @Published var availableDate = Date()
  @Published var locationSelection = "Pittsburgh"
  @Published var conditionSelection = "New"
  @Published var categorySelection = "clothing"
  
  @Published var availableStatus : Bool = false
  
  private var cancellableSet: Set<AnyCancellable> = []
  
  init() {
    loadItemswithPostsAvailable()
  }
  
  func viewBuySell() {
    if(self.renderSell)
    {
      sellButtonForegroundColor = Color(.white)
      sellButtonBackgroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
      buyButtonForegroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
      buyButtonBackgroundColor = Color(.white)
    }
    else{
      sellButtonForegroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
      sellButtonBackgroundColor = Color(.white)
      buyButtonForegroundColor = Color(.white)
      buyButtonBackgroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
    }
  }
  
  func loadItemswithPostsAvailable() {
    viewModel.fetchAllItemsWithPostsAvailable { results in
      self.itemswithPostsAvailableArray = results
    }
  }
  
  func createBuyPost(){
      let ref_title = database.collection("Items").document()
      let ref_post = database.collection("Posts").document()
      let newItemId = ref_title.documentID
      let newPostId = ref_post.documentID
      
      let newItemData = Item(id: newItemId,
                             post_id: newPostId,
                             item_title: self.title,
                             item_description: self.description,
                             item_category: self.categorySelection,
                             item_buy: true,
                             condition: "",
                             price: Double(budget) ?? 0,
                             images: [],
                             zip_code: self.zipCode,
                             delivery: self.delivertRequest,
                             pickup_location: "")
  //                           availableDate: "")
      self.availableStatus = true
      
      let cur_time = Timestamp.init()
      let newPostData = Post(id: newPostId,
                             last_modified_timestamp: cur_time,
                             Availability: "Available",
                             post_creation_date:cur_time)
      
      let auth = Auth.auth()
      let user_id = auth.currentUser?.uid
      
      let updateReference = database.collection("Users").document(user_id!)
      updateReference.getDocument { (document, err) in
        if let err = err {
          print(err.localizedDescription)
        }
        else {
          document?.reference.updateData([
            "my_post_list": FieldValue.arrayUnion([newPostId])
          ])
        }
      }
      
    
      let viewModel = ViewModel()
      viewModel.addItem(item: newItemData)
      viewModel.addPost(post: newPostData)
    }
    
    func createSellPost(){
      let ref_title = database.collection("Items").document()
      let ref_post = database.collection("Posts").document()
      let newItemId = ref_title.documentID
      let newPostId = ref_post.documentID
      
      let newItemData = Item(id: newItemId,
                             post_id: newPostId,
                             item_title: self.title,
                             item_description: self.description,
                             item_category: self.categorySelection,
                             item_buy: false,
                             condition: self.conditionSelection,
                             price: Double(price) ?? 0,
                             images: [],
                             zip_code: "",
                             delivery: self.delivertRequest,
                             pickup_location: self.locationSelection)
      
      self.availableStatus = true
      
      let cur_time = Timestamp.init()
      let newPostData = Post(id: newPostId,
                             last_modified_timestamp: cur_time,
                             Availability: "Available",
                             post_creation_date:cur_time)
      
      let auth = Auth.auth()
      let user_id = auth.currentUser?.uid
      
      let updateReference = database.collection("Users").document(user_id!)
      updateReference.getDocument { (document, err) in
        if let err = err {
          print(err.localizedDescription)
        }
        else {
          document?.reference.updateData([
            "my_post_list": FieldValue.arrayUnion([newPostId])
          ])
        }
      }
      
    
      let viewModel = ViewModel()
      viewModel.addItem(item: newItemData)
      viewModel.addPost(post: newPostData)
    }

}
