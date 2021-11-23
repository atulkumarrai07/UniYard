
import SwiftUI

struct ItemsHome: View {
  @StateObject var itemViewModel: ItemsViewModel
	//aaratrika
	//  @State var searchField: String = ""
	//  @State var displayedRepos = [PostItem]()
	
	//----aaratrika
	
	@EnvironmentObject var loginModel:LoginModel
//	@StateObject var itemViewModel = ItemsViewModel()
	var body: some View {
    
		VStack{
			//        HStack {
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
			//aaratrika
			HStack{
				HStack{
					TextField("Search something here...", text: $itemViewModel.searchString).padding(10)
				}.padding(.leading,40)
				.background(Color(red: 255/255.0, green: 192/255.0, blue: 190/255.0))
				.cornerRadius(10.0)
				.padding(.horizontal)
				//          .onTapGesture {
				//            itemViewModel.isSearching = true
				//            print(itemViewModel.searchString)
				//            itemViewModel.search(searchString: itemViewModel.searchString)
				//
				//          }
				.onChange(of: itemViewModel.searchString, perform: {_ in
					itemViewModel.isSearching = true
          if(itemViewModel.renderSell)
          {
            itemViewModel.searchSell(searchString: itemViewModel.searchString)
          }
          else
          {
            itemViewModel.searchBuy(searchString: itemViewModel.searchString)
          }
					
					
				})
				.overlay(
					HStack{
						Image(systemName: "magnifyingglass").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						Spacer()
						if(itemViewModel.isSearching)
						{
							Button(action: {itemViewModel.searchString = "" }, label: {
								Image(systemName: "xmark.circle.fill").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
									.padding()
							})
						}
					}.padding(.horizontal,30)
				)
			}
			
			//aaratrika
			//          Button(action: {
			//
			//          }){
			//            Image(systemName: "magnifyingglass").resizable().frame(width: 30, height: 30, alignment: .leading).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
			//          }
			//        }.padding()
			
			HStack{
				Button("Sell", action: {
					itemViewModel.renderSell.toggle()
					itemViewModel.searchSell(searchString: itemViewModel.searchString)
					itemViewModel.sortItems(true)
					itemViewModel.viewBuySell()
				}).frame(width: 175, height: 40, alignment: .center).foregroundColor(itemViewModel.sellButtonForegroundColor).background(itemViewModel.sellButtonBackgroundColor).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))).disabled(itemViewModel.renderSell)
				
				Button("Buy", action: {
					itemViewModel.renderSell.toggle()
					itemViewModel.searchBuy(searchString: itemViewModel.searchString)
					itemViewModel.sortItems(false)
					itemViewModel.viewBuySell()
				}).frame(width: 175, height: 40, alignment: .center).foregroundColor(itemViewModel.buyButtonForegroundColor).background(itemViewModel.buyButtonBackgroundColor).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))).disabled(!itemViewModel.renderSell)
			}.padding(.bottom,1)
			
			HStack{
				Text("Current Location:").font(.body).opacity(0.8)
				
				Button(itemViewModel.locationSelection) {
					itemViewModel.showingLocations.toggle()
					
				}.sheet(isPresented: $itemViewModel.showingLocations){
					CampusLocationPicker2(itemViewModel: itemViewModel, locationSelection: $itemViewModel.locationSelection)
				}
				Spacer()
				
				//filter option picker
				Button(action: {
					itemViewModel.showFilter.toggle()
					
				}){Image("filter_icon").resizable()
					.frame(width: 30, height: 25, alignment: .center)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))}
				.sheet(isPresented: $itemViewModel.showFilter){
					if (itemViewModel.renderSell){
						SellFilterView(itemViewModel: itemViewModel)
					} else{
						BuyFilterView(itemViewModel: itemViewModel)
					}
				}
				
				//sort option picker
				Button(action: {
					itemViewModel.showSorts.toggle()
				}){Image("sort_icon").resizable()
					.frame(width: 40, height: 40, alignment: .center)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))}
				.sheet(isPresented: $itemViewModel.showSorts){
					SortView(itemViewModel: itemViewModel)
				}
			}.padding(.horizontal)
			if(itemViewModel.renderSell && itemViewModel.searchString == ""){
				SellListings(itemViewModel: itemViewModel)
			}
			else if(itemViewModel.renderSell && itemViewModel.searchString != "")
			{
				SearchSellListings(itemViewModel: itemViewModel)
			}
			else if(!itemViewModel.renderSell && itemViewModel.searchString == ""){
				BuyListings(itemViewModel: itemViewModel)
			}
			else{
				SearchBuyListings(itemViewModel: itemViewModel)
			}
			Spacer()
		}.navigationBarHidden(true)
    .onAppear{
      itemViewModel.loadItemswithPostsAvailable()
    }
  }
}

//struct ItemsHome_Previews: PreviewProvider {
//	static var previews: some View {
//		ItemsHome()
//		
//	}
//}
