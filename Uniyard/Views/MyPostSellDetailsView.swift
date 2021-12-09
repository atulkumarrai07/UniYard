//import SwiftUI
//import Foundation
//import FirebaseFirestore
//import SDWebImageSwiftUI
//
//struct MyPostSellDetailsView: View {
//	var itemDetails: PostItem
////	@State var availability: String
//	@StateObject var itemDetailViewModel = ItemDetailViewModel()
//
//
//	@Environment(\.presentationMode) var itemDetailsSellPresentation: Binding<PresentationMode>
//	var body: some View {
//	 ZStack{
//		Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
//		VStack{
//		HStack {
//			 Button(action: {
//				itemDetailsSellPresentation.wrappedValue.dismiss()
//			 })
//			 {
//			 Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
//			 }
//			 Text("Item Details")
//			 .font(.largeTitle)
//			 .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
//			 .fontWeight(.heavy)
//			 .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
//			}
//
//			ItemDetails(itemDetails: itemDetails)//item images
//			CardDetailsSellwSold(itemDetails: itemDetails,itemdetailvmodel: itemDetailViewModel)
//
//	 }.onAppear(){
//		itemDetailViewModel.setPostId(postId: itemDetails.postId)
//	}
//	}
// }
//}
//
//
//struct CardDetailsSellwSold: View {
//	@State var itemDetails: PostItem
//	@StateObject var itemdetailvmodel:ItemDetailViewModel
//
// //take
//	//@StateObject var itemdetailvmodel = ItemDetailViewModel()
//	@StateObject var itemsvmodel = ItemsViewModel()
//	@StateObject var savePostViewModel = SavedPostViewModel()
//	@StateObject var chatsViewModel = ChatsViewModel()
// var body: some View {
//	ZStack{
//		ScrollView{
//			VStack{
//			 VStack {
//				HStack{
//
//					Text("[Sell]").foregroundColor(.blue).font(.title3).frame( alignment: .leading)
//					Text(itemDetails.item_title)
//					.font(.title3)
//					.fontWeight(.bold)
//					.frame(alignment: .leading)
//					Spacer()
//				 Button(action: toggled){
//				 Image(systemName: itemDetails.isSaved ? "bookmark.fill" :"bookmark").font(.system(size: 25.0, weight: .bold)).frame(width: 120, height: 50, alignment: .trailing)
//					.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
//				 }.onChange(of: itemDetails.isSaved, perform: { value in
//					if(itemDetails.isSaved)
//					{
//						itemsvmodel.updateSavePost(postId: itemDetails.postId)
//					}
//					else{
//						savePostViewModel.deleteFromSavePost(postId: itemDetails.postId)
//					}
//				 }).onAppear {
//					savePostViewModel.loadSavedPosts()
//				}
//				}
//				HStack{
//					Text("$" + String(itemDetails.price)).font(.title2).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).bold()
//					.frame(width:114,alignment: .leading)
//					Text("List Date: \(convertTimestamp(serverTimestamp: itemDetails.last_modified_timestamp))").font(.subheadline).foregroundColor(.gray).frame(width:200,alignment: .trailing)
//				}
//				Group{
//				 Spacer()
//					IndividualCardDetails("Condition:", text: itemDetails.condition )
//				}
//				Group{
//				 Spacer()
//					IndividualCardDetails("Category:", text: itemDetails.item_category )
//				 Spacer()
//					IndividualCardDetails("Zipcode:", text: itemDetails.zip_code)
//				 Spacer()
//					IndividualCardDetails("Delivery:", text: itemDetails.delivery ? "Available":"Not Available" )
//				 Spacer()
//				}
//				Group{
//					IndividualCardDetails("Location:", text: "Coming soon" )
//				 Spacer()
//					IndividualCardDetails("Pickup/nAddress:", text: itemDetails.pickup_location )
//				 Spacer()
//					IndividualCardDetails("Earliest Available:", text: "Coming soon" )
//				 Spacer()
//				 Text("Description:").bold().font(.subheadline).frame(width:330,alignment: .leading)
//					Text(itemDetails.item_description).padding().font(.subheadline)
//						.frame(width: 330, alignment: .leading)
//						.background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0, opacity: 1.0))
//						.cornerRadius(10)
//					.fixedSize(horizontal: false, vertical: true)
//
//
//					Button(action: {
//						itemsvmodel.markPostSolved(postId: itemDetails.postId)
//						itemDetails.Availability = "No"
//				}
//             , label: {
//             Text("Mark as Sold")
//             })
//          .foregroundColor(.white)
//          .padding(.vertical, 10)
//          .padding(.horizontal, 50)
//          .background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
//          .cornerRadius(15)
//					.opacity((itemDetails.Availability == "Available") ? 1 : 0.5)
//					.disabled(itemDetails.Availability == "No")
//
//				}
//			 }.padding(.top)
//			 .frame(width: 334,height: 490 , alignment: .center)
//			 Spacer()
//		//   BottomBarNav().frame(width: 400).navigationBarHidden(true).onAppear()
//			}.padding()
//			.background(Color(.systemBackground))
//			.cornerRadius(20)
//		}
//	}.navigationBarHidden(true)
// }
//
//	func toggled(){
//	 self.itemDetails.isSaved = !self.itemDetails.isSaved
//	}
//}
//


import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI


struct MyPostSellDetailsView: View {
	@Environment(\.presentationMode) var createSellPresentation: Binding<PresentationMode>
	
	@StateObject var itemDetails : PostItem
	@StateObject var itemsvmodel = ItemsViewModel()
	
	@State private var showingAlert = false
	
	@State var photo : [UIImage] = []
	@State var photoURL : [String] = []
	@State var photoFullURL = [String]()
	@State var any = PHPickerConfiguration()
	
	var conditionList = ["New", "Almost new", "Very good", "Good", "Acceptable"]
	var categoryList=["Clothing", "Books", "Computers",
										"Electronics", "Furniture", "Home appliances",
										"Jewelley, watches", "Music instruments", "Phones",
										"Sporting goods", "Tools", "Toys, games", "Other"]
	
	var locationList = ["Pittsburgh","Australia","Qatar", "Africa"]
	
	//set a date range
	var dateRange: ClosedRange<Date> {
		let min_date = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
		
		let max_date = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
		return min_date...max_date
	}
	
	var itemPriceStr: Binding<String> {
		Binding<String>(
			get: { String(format: "%.02f", Double(itemDetails.price)) },
			set: {
				if let value = NumberFormatter().number(from: $0) {
					itemDetails.price = value.doubleValue
				}
			}
		)
	}
	
	var body: some View {
		ZStack{
			Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {
						UIApplication.shared.endEditing()
						self.createSellPresentation.wrappedValue.dismiss()
					}){
						Image(systemName: "chevron.backward").resizable()
							.frame(width: 15, height: 20, alignment: .center)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					}
					
					Text("My Sell Post")
						.font(.system(size: 25, weight: .heavy))
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}.padding(.trailing).padding(.leading)
				
				// sell item images
				if (itemDetails.images.count > 0){
					TabView {
						ForEach(itemDetails.images, id: \.self) {pho in
							WebImage(url: URL(string: pho))
								.resizable()
								.scaledToFit()
								.cornerRadius(5)
								.frame(height: 250, alignment: .center)
						}
					}
					.frame(width: 300, height: 200, alignment: .center)
					.tabViewStyle(PageTabViewStyle())
					.cornerRadius(54.0)
				}
					
					//post details
					Form {
						Section(header: Text("Title")) {
							TextEditor(text: $itemDetails.item_title)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						Section(header: Text("Price (USD)")) {
							TextField("$0.00", text: itemPriceStr)
								.keyboardType(.decimalPad)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						Section {
							Picker("Condition", selection: $itemDetails.condition) {
								ForEach(conditionList, id: \.self) {
									Text($0)
								}}
							
							Picker("Category", selection: $itemDetails.item_category) {
								ForEach(categoryList, id: \.self) {
									Text($0)
								}}
							
							Toggle(isOn: $itemDetails.delivery) {
								Text("Delivery request")
							}
							
							Picker("Location", selection: $itemDetails.pickup_location) {
								ForEach(locationList, id: \.self) {
									Text($0)
								}}
						}.textCase(nil)
						.font(.system(size: 18))
						
						
						Section(header: Text("Item description")) {
							TextEditor(text: $itemDetails.item_description)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
					}//form
					.cornerRadius(15)
					.padding(.leading, 20)
					.padding(.trailing, 20)
					
					Button(action: {
						showingAlert = true
						itemsvmodel.saveSellPost(itemId: itemDetails.itemId, item_title: itemDetails.item_title, item_description: itemDetails.item_description, item_category: itemDetails.item_category,
																		 condition: itemDetails.condition,  price: String(itemDetails.price), zip_code: itemDetails.zip_code, delivery: itemDetails.delivery, pickup_location: itemDetails.pickup_location)
					}
					, label: {Text("Save").frame(width: 300, height: 50, alignment: .center)
						.font(.system(size: 25, weight: .heavy))
						.foregroundColor(.white)
						.background(Color(red: 128/255.0,green: 0/255.0,blue: 0/255.0, opacity: 1.0))
						.cornerRadius(15)
					})
					.padding(.vertical, 10)
					.padding(.horizontal, 50)
					.opacity(((!itemDetails.item_title.isEmpty) && (!itemDetails.item_description.isEmpty) && (itemDetails.Availability == "Available")) ? 1 : 0.5)
					.opacity(((!itemDetails.item_title.isEmpty) || (!itemDetails.item_description.isEmpty) || (itemDetails.Availability == "Available")) ? 1 : 0.5)
					.alert(isPresented:$showingAlert)
					{Alert(title: Text("Success"),
								 message: Text("Changes have been saved!"),
								 dismissButton: .default(Text("OK")))
					}
					
					Button(action: {
						itemsvmodel.markPostSolved(postId: itemDetails.postId)
						itemDetails.Availability = "No"
					}
					, label: {
						Text("Mark as resolved")
							.frame(width: 300, height: 50, alignment: .center)
							.font(.system(size: 20, weight: .heavy))
							.foregroundColor(.white)
							.background(Color(red: 128/255.0,
																green: 0/255.0,
																blue: 0/255.0, opacity: 1.0))
							.cornerRadius(15)
					})
					.padding(.vertical, 10)
					.padding(.horizontal, 50)
					.opacity(((!itemDetails.item_title.isEmpty) && (!itemDetails.item_description.isEmpty) && (itemDetails.Availability == "Available")) ? 1 : 0.5)
					.opacity(((!itemDetails.item_title.isEmpty) || (!itemDetails.item_description.isEmpty) || (itemDetails.Availability == "Available")) ? 1 : 0.5)
					
				}.onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
			}.navigationBarHidden(true)
		}
}
	
