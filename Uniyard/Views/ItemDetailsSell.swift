import SwiftUI
import Foundation
import FirebaseFirestore

struct ItemDetailsSell: View {
	var itemDetails: PostItem
	@Environment(\.presentationMode) var itemDetailsSellPresentation: Binding<PresentationMode>
	var body: some View {
		ZStack{
			Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {
						itemDetailsSellPresentation.wrappedValue.dismiss()
					})
					{
						Image(systemName: "chevron.backward").resizable().frame(width: 15, height: 20, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
					}
					Text("Item Details")
						.font(.system(size: 25, weight: .heavy))
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.fontWeight(.heavy)
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}
				ItemDetails()
				CardDetails(itemDetails: itemDetails)
				
			}
		}
	}
}
struct ItemDetails: View {
	var body: some View {
		TabView {
			ForEach(0 ..< 5) {_ in
				Image(uiImage: #imageLiteral(resourceName: "Login_logo"))
					.resizable()
					.scaledToFit()
					.cornerRadius(5)
					.frame(height: 200)
			}
		}
		.frame(width: 300, height: 200, alignment: .center)
		.tabViewStyle(PageTabViewStyle())
		.cornerRadius(54.0).padding(.bottom)
		
	}
}
struct CardDetails: View {
	var itemDetails: PostItem
	//take
	@StateObject var itemdetailvmodel = ItemDetailViewModel()
	var body: some View {
		ZStack{
			ScrollView{
				VStack{
					VStack {
						HStack{
							
							Text("[Sell]").foregroundColor(.blue).font(.title3).frame( alignment: .leading)
							Text(itemDetails.item_title)
								.font(.title3)
								.fontWeight(.bold)
								.frame(alignment: .leading)
							Spacer()
							Button(action: itemdetailvmodel.toggled){
								Image(systemName: itemdetailvmodel.showBookmarkSelector ? "bookmark.fill" :"bookmark").font(.system(size: 25.0, weight: .bold)).frame(width: 120, height: 50, alignment: .trailing)
									.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
							}
						}
						HStack{
							Text("$" + String(itemDetails.price)).font(.title2).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).bold()
								.frame(width:104,alignment: .leading)
							Text("List Date: 2019-09-31").font(.subheadline).foregroundColor(.gray).frame(width:220,alignment: .trailing)
						}
						Group{
							//         Spacer()
							//          IndividualCardDetails("Status:", text: itemDetails.Availability )
							Spacer()
							IndividualCardDetails("Condition:", text: itemDetails.condition )
						}
						Group{
							Spacer()
							IndividualCardDetails("Category:", text: itemDetails.item_category )
							Spacer()
							IndividualCardDetails("Zipcode:", text: itemDetails.zip_code)
							Spacer()
							IndividualCardDetails("Delivery:", text: itemDetails.delivery ? "Available":"Not Available" )
							Spacer()
						}
						Group{
							IndividualCardDetails("Location:", text: "Coming soon" )
							Spacer()
							IndividualCardDetails("Pickup/nAddress:", text: itemDetails.pickup_location )
							Spacer()
							IndividualCardDetails("Earliest Available:", text: "Coming soon" )
							Spacer()
							Text("Description:").bold().font(.subheadline).frame(width:330,alignment: .leading)
							Text(itemDetails.item_description).padding().font(.subheadline)
								.frame(width: 330, alignment: .leading)
								.background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0, opacity: 1.0))
								.cornerRadius(10)
								.fixedSize(horizontal: false, vertical: true)
							Button(action: {}
										 , label: {
											Text("Chat")
										})
								.foregroundColor(.white)
								.padding(.vertical, 10)
								.padding(.horizontal, 50)
								.background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
								.cornerRadius(15)
						}
					}.padding(.top)
					.frame(width: 334,height: 490 , alignment: .center)
					Spacer()
					//   BottomBarNav().frame(width: 400).navigationBarHidden(true).onAppear()
				}.padding()
				.background(Color(.systemBackground))
				.cornerRadius(20)
			}
		}.navigationBarHidden(true)
	}
}

struct IndividualCardDetails: View {
	private var caption:String
	private var text:String
	//  @Binding var text:String
	init(_ caption: String, text: String) {
		self.caption = caption
		// self._text = text
		self.text = text
	}
	var body: some View {
		VStack(alignment: .leading){
			HStack
			{
				Text(caption).bold().font(.subheadline).frame(alignment: .leading)
				Text(text).font(.subheadline).frame(width:130,alignment: .leading)
				Spacer()
			}
		}
	}
}
struct ItemDetailsSell_Previews: PreviewProvider {
	static var previews: some View {
		let item:PostItem = PostItem(postId: "", last_modified_timestamp: Timestamp.init(), Availability: "", post_creation_date: Timestamp.init(), itemId: "", item_title: "", item_description: "", item_category: "", item_buy: false, condition: "", price: 0.0, images: [], zip_code: "", delivery: false, pickup_location: "")
		ItemDetailsSell(itemDetails:item)
	}
}
