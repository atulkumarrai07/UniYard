import SwiftUI
import Foundation
import FirebaseFirestore
import SDWebImageSwiftUI

struct MyPostSellDetailsView: View {
	var itemDetails: PostItem
//	@State var availability: String
	@StateObject var itemDetailViewModel = ItemDetailViewModel()
	
	
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
			 Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
			 }
			 Text("Item Details")
			 .font(.largeTitle)
			 .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
			 .fontWeight(.heavy)
			 .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
			}
			
			ItemDetails(itemDetails: itemDetails)//item images
			CardDetailsSellwSold(itemDetails: itemDetails,itemdetailvmodel: itemDetailViewModel)

	 }.onAppear(){
		itemDetailViewModel.setPostId(postId: itemDetails.postId)
	}
	}
 }
}


struct CardDetailsSellwSold: View {
	@State var itemDetails: PostItem
	@StateObject var itemdetailvmodel:ItemDetailViewModel
	
 //take
	//@StateObject var itemdetailvmodel = ItemDetailViewModel()
	@StateObject var itemsvmodel = ItemsViewModel()
	@StateObject var savePostViewModel = SavedPostViewModel()
	@StateObject var chatsViewModel = ChatsViewModel()
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
				 Button(action: toggled){
				 Image(systemName: itemDetails.isSaved ? "bookmark.fill" :"bookmark").font(.system(size: 25.0, weight: .bold)).frame(width: 120, height: 50, alignment: .trailing)
					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
				 }.onChange(of: itemDetails.isSaved, perform: { value in
					if(itemDetails.isSaved)
					{
						itemsvmodel.updateSavePost(postId: itemDetails.postId)
					}
					else{
						savePostViewModel.deleteFromSavePost(postId: itemDetails.postId)
					}
				 }).onAppear {
					savePostViewModel.loadSavedPosts()
				}
				}
				HStack{
					Text("$" + String(itemDetails.price)).font(.title2).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).bold()
					.frame(width:114,alignment: .leading)
					Text("List Date: \(convertTimestamp(serverTimestamp: itemDetails.last_modified_timestamp))").font(.subheadline).foregroundColor(.gray).frame(width:200,alignment: .trailing)
				}
				Group{
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
					
         
					Button(action: {
						itemsvmodel.markPostSolved(postId: itemDetails.postId)
						itemDetails.Availability = "No"
				}
             , label: {
             Text("Mark as Sold")
             })
          .foregroundColor(.white)
          .padding(.vertical, 10)
          .padding(.horizontal, 50)
          .background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          .cornerRadius(15)
					.opacity((itemDetails.Availability == "Available") ? 1 : 0.5)
					.disabled(itemDetails.Availability == "No")
			
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
	
	func toggled(){
	 self.itemDetails.isSaved = !self.itemDetails.isSaved
	}
}

