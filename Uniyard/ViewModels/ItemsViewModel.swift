
import SwiftUI
import Combine
import FirebaseFirestore

class ItemsViewModel: ObservableObject {
  @Published var location: String = "Pittsburgh"
  @Published var showingLocations:Bool = false
  @Published var renderSell:Bool = false
  @Published var sellButtonForegroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
  @Published var sellButtonBackgroundColor = Color(.white)
  @Published var buyButtonForegroundColor = Color(.white)
  @Published var buyButtonBackgroundColor = Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)
  
	//Iris
	@Published var title = ""
	@Published var pickUpAddress = ""
	
	@Published var price = ""
	@Published var budget = ""
	
	@Published var delivertRequest = false
	@Published var zipCode = ""
	@Published var description = ""
	
	@Published var showingAlert = false
	@Published var isValid = false
	
	@Published var availableDate = Date()
	@Published var locationSelection = "Pittsburgh"
	@Published var conditionSelection = "New"
	@Published var categorySelection = "clothing"
	
	private var cancellableSet: Set<AnyCancellable> = []
	
	
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
	
	func createBuyPost(title: String, categorySelection:String, price: String, delivertRequest: Bool,
										 zipCode: String, description: String ){
		
	
	}
	
}
