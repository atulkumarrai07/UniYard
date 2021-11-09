
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
  
  
  //aaratrika
  @Published var searchString: String = ""
  @Published var isSearching: Bool = false
  @Published var filteredPosts:[PostItem] = []
  //--aaratrika
  //iris
  @Published var showSorts: Bool = false
  @Published var sortOption: String = "Newest Date First"
  @Published var showFilter: Bool = false
  @Published var sell_filter_minPrice: String = ""
  @Published var sell_filter_maxPrice = ""
  @Published var sell_filter_conditionSelection = "All"
  @Published var sell_filter_categorySelection = "All"
  @Published var buy_filter_minPrice = ""
  @Published var buy_filter_maxPrice = ""
  @Published var buy_filter_categorySelection = "All"
  
  @Published var sell_filteredItems:[PostItem] = []
  @Published var buy_filteredItems:[PostItem] = []
  @Published var sort_NewDateFirst: Bool = true
  @Published var sort_LowPriceFirst: Bool = true

  //--iris
  private var cancellableSet: Set<AnyCancellable> = []
  
  init() {
    loadItemswithPostsAvailable()
  }
  //aaratrika
  func search(searchString: String) {
   // print("Search string:", searchString)
      filteredPosts = itemswithPostsAvailableArray.filter { card in
        return card.item_title.lowercased().contains(searchString.lowercased())
        }
    }
  //--aaratrika
  
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
  
//  func loadItemswithPostsAvailable() {
//    viewModel.fetchAllItemsWithPostsAvailable { results in
//      self.itemswithPostsAvailableArray = results
//    }
//  }
  //sort buy or sell item lists.
    func sortItems( _ sellItems: Bool)  {
      if (sortOption == "Newest Date First"){
        if (sellItems){
          sell_filteredItems = sortItems_newDateFirst(postItem: sell_filteredItems)
        } else{
          buy_filteredItems = sortItems_newDateFirst(postItem: buy_filteredItems)
        }
      }
      
      if (sortOption == "Oldest Date First"){
        if (sellItems){
          sell_filteredItems = sortItems_oldDateFirst(postItem: sell_filteredItems)
        } else{
          buy_filteredItems = sortItems_oldDateFirst(postItem: buy_filteredItems)
        }
      }
      
      if (sortOption == "Lowest Price First"){
        if (sellItems){
          sell_filteredItems = sortItems_lowPriceFirst(postItem: sell_filteredItems)
        } else{
          buy_filteredItems = sortItems_lowPriceFirst(postItem: buy_filteredItems)
        }
      }
      
      if (sortOption == "Highest Price First"){
        if (sellItems){
          sell_filteredItems = sortItems_highPriceFirst(postItem: sell_filteredItems)
        } else{
          buy_filteredItems = sortItems_highPriceFirst(postItem: buy_filteredItems)
        }
      }
    }
    
    
    func loadItemswithPostsAvailable() {
      viewModel.fetchAllItemsWithPostsAvailable { results in
        self.itemswithPostsAvailableArray = results
        self.filterBuyItems()
        self.filterSellItems()
        self.sortItems(true)   //sort for sell listings by date
        self.sortItems(false) //sort for buy listings by date
      }
      
    }
    
    func sortItems_lowPriceFirst(postItem: [PostItem] ) -> [PostItem]{
      return postItem.sorted(by: {$0.price <= $1.price})
    }
    
    func sortItems_highPriceFirst(postItem: [PostItem] ) -> [PostItem]{
      return postItem.sorted(by: {$0.price >= $1.price})
    }
    
    func sortItems_newDateFirst(postItem: [PostItem] ) -> [PostItem]{
  //    return postItem.sorted(by: { $0.post_creation_date.dateValue() >= $1.post_creation_date.dateValue()})
  //    return postItem.sorted(by: { $0.post_creation_date.compare($1.post_creation_date) == .orderedDescending})
      let result =  postItem.sorted(by: {
        if ($0.post_creation_date.seconds == $1.post_creation_date.seconds){
          return $0.post_creation_date.nanoseconds >= $1.post_creation_date.nanoseconds
        }

        return $0.post_creation_date.seconds >= $1.post_creation_date.seconds
      })

      return result
    }
    
    func sortItems_oldDateFirst(postItem: [PostItem] ) -> [PostItem]{
      let result =  postItem.sorted(by: {
        if ($0.post_creation_date.seconds == $1.post_creation_date.seconds){
          return $0.post_creation_date.nanoseconds <= $1.post_creation_date.nanoseconds
        }

        return $0.post_creation_date.seconds <= $1.post_creation_date.seconds
      })

      return result
      
      
  //    return postItem.sorted(by: { $0.post_creation_date.dateValue() <= $1.post_creation_date.dateValue()})
  //    return postItem.sorted(by: { $0.post_creation_date.seconds < $1.post_creation_date.seconds})
  //    return postItem.sorted(by: { $0.post_creation_date.compare($1.post_creation_date) == .orderedAscending})
    }
    
    //filter sell listings
    func filterSellItems(){
      sell_filteredItems = itemswithPostsAvailableArray.filter({item in return !item.item_buy})
        .filter({item in return item.price >= (Double(sell_filter_minPrice) ?? 0)})
        .filter({item in return item.price <= (Double(sell_filter_maxPrice) ?? Double.infinity)})

      if (sell_filter_conditionSelection != "All"){
        self.sell_filteredItems = self.itemswithPostsAvailableArray.filter({
          ($0.item_category == sell_filter_categorySelection)
      })
      }

      if (sell_filter_conditionSelection != "All"){
        self.sell_filteredItems = self.itemswithPostsAvailableArray.filter({
          ($0.condition == sell_filter_conditionSelection)
      })
      }
    }
    
    //filter buy listings
    func filterBuyItems(){
      buy_filteredItems = itemswithPostsAvailableArray.filter({item in return item.item_buy})
        .filter({item in return item.price >= (Double(buy_filter_minPrice) ?? 0)})
        .filter({item in return item.price <= (Double(buy_filter_maxPrice) ?? Double.infinity)})
  //    print("Filtering")
  //    print(buy_filteredItems)
      if (buy_filter_categorySelection != "All"){
        self.buy_filteredItems = self.itemswithPostsAvailableArray.filter({
          ($0.item_category == buy_filter_categorySelection)
      })
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

