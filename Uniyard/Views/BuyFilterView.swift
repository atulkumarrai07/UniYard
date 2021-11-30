import SwiftUI

struct BuyFilterView: View {
	@StateObject var itemViewModel:ItemsViewModel
	
	@Environment(\.presentationMode) var itemBuyFilter: Binding< PresentationMode>
	
	var categoryList = ["All", "Clothing", "Books", "Computers",
											"Electronics", "Furniture", "Home appliances",
											"Jewelley, watches", "Music instruments", "Phones",
											"Sporting goods", "Tools", "Toys, games", "Other"]
	
	
	var body: some View{
		VStack{
			HStack{
				Spacer()
				Button("Done"){
					itemViewModel.filterBuyItems()
					
					self.itemBuyFilter.wrappedValue.dismiss()
				}
			}.padding()
			
			
			NavigationView{
				Form {
					Section(header: Text("Minimum budget")) {
						TextField("$0.00", text: $itemViewModel.buy_filter_minPrice)
							.keyboardType(.decimalPad)
					}.textCase(nil)
					.font(.system(size: 18))
					.foregroundColor(.black)
					
					Section(header: Text("Maximum budget")) {
						TextField("$0.00", text: $itemViewModel.buy_filter_maxPrice)
							.keyboardType(.decimalPad)
					}.textCase(nil)
					.font(.system(size: 18))
					.foregroundColor(.black)
					
					Section {
						Picker("Category", selection: $itemViewModel.buy_filter_categorySelection) {
							ForEach(categoryList, id: \.self) {
								Text($0)
							}}
					}
					
					Button("Clear all") {
						itemViewModel.buy_filter_minPrice = ""
						itemViewModel.buy_filter_maxPrice = ""
						itemViewModel.buy_filter_categorySelection = "All"
					}
				}
				
			}.navigationBarHidden(true)
		}
	}}
