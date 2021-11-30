import SwiftUI

struct SellFilterView: View {
	@StateObject var itemViewModel:ItemsViewModel

  @Environment(\.presentationMode) var itemSellFilter: Binding< PresentationMode>
  
  var conditionList = ["All", "New", "Almost new", "Very good", "Good", "Acceptable"]
  
	var categoryList = ["All", "Clothing", "Books", "Computers",
											"Electronics", "Furniture", "Home appliances",
											"Jewelley, watches", "Music instruments", "Phones",
											"Sporting goods", "Tools", "Toys, games", "Other"]

  
  var body: some View{
    VStack{
      HStack{
        Spacer()
        Button("Done"){
          itemViewModel.filterSellItems()
          self.itemSellFilter.wrappedValue.dismiss()
        }
      }.padding()
      
      
      NavigationView{
          Form {
            Section(header: Text("Minimum price")) {
							TextField("$0.00", text: $itemViewModel.sell_filter_minPrice)
                .keyboardType(.decimalPad)
            }.textCase(nil)
            .font(.system(size: 18))
            .foregroundColor(.black)
            
            Section(header: Text("Maximum price")) {
							TextField("$0.00", text: $itemViewModel.sell_filter_maxPrice)
                .keyboardType(.decimalPad)
            }.textCase(nil)
            .font(.system(size: 18))
            .foregroundColor(.black)
            
            Section {
							Picker("Condition", selection: $itemViewModel.sell_filter_conditionSelection) {
                ForEach(conditionList, id: \.self) {
                  Text($0)
                }}
              
							Picker("Category", selection: $itemViewModel.sell_filter_categorySelection) {
                ForEach(categoryList, id: \.self) {
                  Text($0)
                }}
            }
						
						Button("Clear all") {
							itemViewModel.sell_filter_minPrice = ""
							itemViewModel.sell_filter_maxPrice = ""
							itemViewModel.sell_filter_conditionSelection = "All"
							itemViewModel.sell_filter_categorySelection = "All"
						}
          }
        
      }.navigationBarHidden(true)
    }
  }}
