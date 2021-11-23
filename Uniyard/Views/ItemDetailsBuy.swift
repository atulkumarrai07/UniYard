import SwiftUI
import Foundation
import FirebaseFirestore

struct ItemDetailsBuy: View {
	var itemDetails:PostItem
	@Environment(\.presentationMode) var itemDetailsBuyPresentation: Binding<PresentationMode>
	var body: some View {
		ZStack{
			Color(red: 214/255.0, green: 158/255.0, blue: 158/255.0, opacity: 1.0)
				.ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {
						itemDetailsBuyPresentation.wrappedValue.dismiss()
					})
					{
						Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
					}
					Text("Item Details")
						.font(.largeTitle)
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.fontWeight(.heavy)
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}
				CardDetailsBuy(itemDetails:itemDetails)
			}
		}
	}
}
struct CardDetailsBuy: View {
	@State var itemDetails:PostItem
	//take
  @StateObject var itemsvmodel = ItemsViewModel()
  @StateObject var savePostViewModel = SavedPostViewModel()
	var body: some View {
		ZStack{
			VStack{
				VStack{
					HStack{
						Text("[Buy]").font(.title3).foregroundColor(.blue).frame(alignment: .leading)
						Text(itemDetails.item_title).font(.title3).fontWeight(.bold).frame(alignment: .leading)
						Spacer()
            Button(action: toggled){
              Image(systemName: itemDetails.isSaved ? "bookmark.fill" :"bookmark").font(.system(size: 25.0, weight: .bold))
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.frame(width: 120, height: 50, alignment: .trailing)
            }.onChange(of: itemDetails.isSaved, perform: { value in
              if(itemDetails.isSaved)
              {
                itemsvmodel.updateSavePost(postId: itemDetails.postId)
              }
              else{
                savePostViewModel.deleteFromSavePost(postId: itemDetails.postId)
              }
             })
          .onAppear {
            savePostViewModel.loadSavedPosts()
          }
					}
					
					HStack{
						Text("$" +  String(itemDetails.price)).font(.title2).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).bold()
							.frame(width:104,alignment: .leading)
						Text("List Date: 2019-09-31").font(.subheadline).foregroundColor(.gray).frame(width:220,alignment: .trailing)
					}
					
					Group{
						Spacer()
						IndividualCardDetails("Budget:", text: "$" + String(itemDetails.price) )
					}
					Group{
						Spacer()
						IndividualCardDetails("Category:", text: itemDetails.item_category )
						Spacer()
						IndividualCardDetails("Zipcode:", text: itemDetails.zip_code )
						Spacer()
						IndividualCardDetails("Delivery:", text: itemDetails.delivery ? "Yes":"No" )
						Spacer()
					}
					Group{
						IndividualCardDetails("Pickup\nLocation:", text: itemDetails.pickup_location)
						Spacer()
						Text("Description:").bold().font(.subheadline).frame(width:330,alignment: .leading)
						Text(itemDetails.item_description).padding().font(.subheadline)
							.frame(width: 330, alignment: .leading)
							.background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0, opacity: 1.0))
							.fixedSize(horizontal: false, vertical: true)
							.cornerRadius(10)
						Button(action: {}
									 , label: {Text("Chat")})
							.foregroundColor(.white)
							
							.padding(.vertical, 10)
							.padding(.horizontal, 50)
							.background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
							.cornerRadius(15)
					}
				}.padding(.top)
				.frame(width: 334,height: 490 , alignment: .leading)
				Spacer()
				//   BottomBarNav().frame(width: 400).navigationBarHidden(true).onAppear()
			}.padding()
			.background(Color(.systemBackground))
			.cornerRadius(20)
			.navigationBarHidden(true)
		}
	}
  
  func toggled(){
//   self.showBookmarkSelector = !self.showBookmarkSelector
   self.itemDetails.isSaved = !self.itemDetails.isSaved
  }
  
}
struct ItemDetailsBuy_Previews: PreviewProvider {
	static var previews: some View {
    let item:PostItem = PostItem(postId: "", last_modified_timestamp: Timestamp.init(), Availability: "", post_creation_date: Timestamp.init(), itemId: "", item_title: "", item_description: "", item_category: "", item_buy: false, condition: "", price: 0.0, images: [], zip_code: "", delivery: false, pickup_location: "", isSaved:false)
		ItemDetailsBuy(itemDetails: item)
	}
}
