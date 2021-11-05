
import SwiftUI

struct ItemsHome: View {
	@EnvironmentObject var loginModel:LoginModel
	@StateObject var itemViewModel = ItemsViewModel()
	
	var body: some View {
		VStack{
			HStack {
				//          Button(action: {
				//            self.ItemHomePresentation.wrappedValue.dismiss()
				//          }){
				//            Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
				//          }
				
				Text("Items")
					.font(.largeTitle)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					.fontWeight(.heavy)
					.frame(maxWidth: .infinity, alignment: .center).padding(.leading)
				
				Button(action: {
					
				}){
					Image(systemName: "magnifyingglass").resizable().frame(width: 30, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
				}
			}.padding()
			
			HStack{
				Button("Sell", action: {
					itemViewModel.renderSell.toggle()
					itemViewModel.filterSellItems()
					itemViewModel.sortItems(true)
					itemViewModel.viewBuySell()
					
				}).frame(width: 175, height: 40, alignment: .center).foregroundColor(itemViewModel.sellButtonForegroundColor).background(itemViewModel.sellButtonBackgroundColor).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))).disabled(itemViewModel.renderSell)
				
				Button("Buy", action: {
					itemViewModel.renderSell.toggle()
					itemViewModel.filterBuyItems()
					itemViewModel.sortItems(false)
					itemViewModel.viewBuySell()
					
				}).frame(width: 175, height: 40, alignment: .center).foregroundColor(itemViewModel.buyButtonForegroundColor).background(itemViewModel.buyButtonBackgroundColor).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))).disabled(!itemViewModel.renderSell)
			}.padding(.bottom,1)
			
			
			HStack{
				Text("Current Location:").font(.body).opacity(0.8)
				
				//Location picker
				Button(itemViewModel.location) {
					itemViewModel.showingLocations.toggle()
				}.sheet(isPresented: $itemViewModel.showingLocations){
					CampusLocationPicker2(location: $itemViewModel.location)
				}
				
				Spacer()
				
				//				//filter option picker
				Button(action: {
					itemViewModel.showFilter.toggle()
					
//					if (itemViewModel.renderSell){
//						itemViewModel.filterSellItems()
//					} else{
//						itemViewModel.filterBuyItems()
//					}
					
				}){Image("filter_icon").resizable()
					.frame(width: 30, height: 25, alignment: .center)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))}
				.sheet(isPresented: $itemViewModel.showFilter){
					if (itemViewModel.renderSell){
						SellFilterView(sell_filter_minPrice: $itemViewModel.sell_filter_minPrice, sell_filter_maxPrice: $itemViewModel.sell_filter_maxPrice, sell_conditionSelection: $itemViewModel.sell_filter_conditionSelection, sell_categorySelection: $itemViewModel.sell_filter_categorySelection)
					} else{
						BuyFilterView(buy_filter_minPrice: $itemViewModel.buy_filter_minPrice, buy_filter_maxPrice: $itemViewModel.buy_filter_maxPrice, buy_categorySelection: $itemViewModel.buy_filter_categorySelection)
					}
				}
				
				//sort option picker
				Button(action: {
					itemViewModel.showSorts.toggle()
					
//					if(itemViewModel.renderSell){
//						itemViewModel.sortItems(true)
//					}else{
//						itemViewModel.sortItems(false)
//					}
					
				}){Image("sort_icon").resizable()
					.frame(width: 40, height: 40, alignment: .center)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))}
				.sheet(isPresented: $itemViewModel.showSorts){
					SortView(sortOption: $itemViewModel.sortOption)
				}
			}.padding(.horizontal)
			
			if(itemViewModel.renderSell){
				SellListings(itemViewModel: itemViewModel)
			}
			else{
				BuyListings(itemViewModel: itemViewModel)
			}
			Spacer()
		}.navigationBarHidden(true)
	}
}

struct ItemsHome_Previews: PreviewProvider {
	static var previews: some View {
		ItemsHome()
		
	}
}
