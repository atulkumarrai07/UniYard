import SwiftUI

struct SellFilterView: View {
	@State var sell_filter_minPrice:Binding<String>
	@State var sell_filter_maxPrice:Binding<String>
	@State var sell_conditionSelection:Binding<String>
	@State var sell_categorySelection:Binding<String>
	
	@StateObject var itemViewModel = ItemsViewModel()

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
							TextField("$0.00", text: sell_filter_minPrice)
								.keyboardType(.decimalPad)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						Section(header: Text("Maximum price")) {
							TextField("$0.00", text: sell_filter_maxPrice)
								.keyboardType(.decimalPad)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						Section {
							Picker("Condition", selection: sell_conditionSelection) {
								ForEach(conditionList, id: \.self) {
									Text($0)
								}}
							
							Picker("Category", selection: sell_categorySelection) {
								ForEach(categoryList, id: \.self) {
									Text($0)
								}}
						}
					}
				
			}.navigationBarHidden(true)
		}
	}}




	
//	var body: some View{
//		VStack{
//			HStack{
//				Spacer()
//				Button("Done"){
//					self.itemSellFilter.wrappedValue.dismiss()
//				}
//			}.padding()
//
//
//			NavigationView{
//					Form {
//						Section(header: Text("Minimum price")) {
//							TextField("$0.00", text: sell_filter_minPrice)
//								.keyboardType(.decimalPad)
//						}.textCase(nil)
//						.font(.system(size: 18))
//						.foregroundColor(.black)
//
//						Section(header: Text("Maximum price")) {
//							TextField("$0.00", text: sell_filter_maxPrice)
//								.keyboardType(.decimalPad)
//						}.textCase(nil)
//						.font(.system(size: 18))
//						.foregroundColor(.black)
//
//						Section {
//							Picker("Condition", selection: sell_conditionSelection) {
//								ForEach(conditionList, id: \.self) {
//									Text($0)
//								}}
//
//							Picker("Category", selection: sell_categorySelection) {
//								ForEach(categoryList, id: \.self) {
//									Text($0)
//								}}
//						}
//					}
//			}.navigationBarHidden(true)
//		}
//	}}
//
//
////struct FilterView_Previews: PreviewProvider {
////	@StateObject var item_vm = ItemsViewModel()
////	static var previews: some View {
////		FilterView(filter_minPrice: item_vm.filter_minPrice, filter_maxPrice: $item_vm.filter_maxPrice, conditionSelection: $item_vm.filter_conditionSelection, categorySelection: $item_vm.filter_categorySelection)
////	}
////}
