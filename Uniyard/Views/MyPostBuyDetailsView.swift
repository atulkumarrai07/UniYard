import SwiftUI

struct MyPostBuyDetailsView: View {
	@Environment(\.presentationMode) var createBuyPresentation: Binding<PresentationMode>
	@StateObject var itemDetails : PostItem
	@StateObject var itemsvmodel = ItemsViewModel()
	
	@State private var showingAlert = false
	
	var categoryList=["Clothing", "Books", "Computers",
										"Electronics", "Furniture", "Home appliances",
										"Jewelley, watches", "Music instruments", "Phones",
										"Sporting goods", "Tools", "Toys, games", "Other"]
	
	var locationList = ["Pittsburgh","Australia","Qatar", "Africa"]
	
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
		//  NavigationView {
		ZStack{
			Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {
						UIApplication.shared.endEditing()
						self.createBuyPresentation.wrappedValue.dismiss()
					}){
						Image(systemName: "chevron.backward").resizable()
							.frame(width: 15, height: 20, alignment: .center)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
					}
					Text("My Buy Post")
						.font(.system(size: 25, weight: .heavy))
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}.padding()
				
				Form {
					Section(header: Text("Title")) {
						TextEditor(text: $itemDetails.item_title)
					}
					.textCase(nil)
					.font(.system(size: 18))
					.foregroundColor(.black)
					
					Section(header: Text("Budget (USD)")) {
						TextField("$0.00", text: itemPriceStr)
							.keyboardType(.decimalPad)
					}.textCase(nil)
					.font(.system(size: 18))
					.foregroundColor(.black)
					
					Section {
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
					
					
					Section(header: Text("Zip code")) {
						TextField("12345", text: $itemDetails.zip_code)
							.keyboardType(.numberPad)
					}.textCase(nil)
					.font(.system(size: 18))
					.foregroundColor(.black)
					
					Section(header: Text("Item description")) {
						TextEditor(text: $itemDetails.item_description)
					}.textCase(nil)
					.font(.system(size: 18))
					.foregroundColor(.black)
				}.cornerRadius(15)
				.padding(.leading, 20)
				.padding(.trailing, 20)
				
				Button(action: {
					showingAlert = true
					itemsvmodel.saveBuyPost(itemId: itemDetails.itemId, item_title: itemDetails.item_title,
																	item_description: itemDetails.item_description, item_category: itemDetails.item_category,
																	price: String(itemDetails.price), zip_code: itemDetails.zip_code, delivery: itemDetails.delivery, pickup_location: itemDetails.pickup_location)
				}
				, label: {
					Text("Save")
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
				.alert(isPresented: $showingAlert)
				{
					Alert(title: Text("Success"),
								message: Text("Changed has been saved!"),
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
			
				
			}//zstack
			.onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
			.navigationBarHidden(true)
		}
	}
}


