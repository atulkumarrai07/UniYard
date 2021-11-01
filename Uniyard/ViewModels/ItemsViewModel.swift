
import SwiftUI
import Combine

class ItemsViewModel: ObservableObject {
  var viewModel = ViewModel()
  @Published var location:String = "Pittsburgh"
  @Published var showingLocations:Bool = false
  @Published var renderSell:Bool = false
  @Published var sellButtonForegroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
  @Published var sellButtonBackgroundColor = Color(.white)
  @Published var buyButtonForegroundColor = Color(.white)
  @Published var buyButtonBackgroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
  @Published var itemswithPostsAvailableArray:[PostItem] = []
  
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
}
