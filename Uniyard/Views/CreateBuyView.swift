import SwiftUI

struct CreateBuyView: View {
	@Environment(\.presentationMode) var createBuyPresentation: Binding<PresentationMode>
	@StateObject var item_vm = ItemsViewModel()
	
	var categoryList=["clothing", "books", "computers",
										"electronics", "furniture", "home appliances", "jewelley, watches",
										"music instruments", "phones", "sporting goods", "tools",
										"toys, games", "other"]
	
	
	var body: some View {
		NavigationView {
			ZStack{
				Color(red: 214/255.0, green: 158/255.0, blue: 158/255.0, opacity: 1.0)
					.ignoresSafeArea(.all)
				VStack{
					HStack {
						Button(action: {
							self.createBuyPresentation.wrappedValue.dismiss()
						}){
							Image(systemName: "chevron.backward").resizable()
								.frame(width: 15, height: 20, alignment: .center)
								.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						}
						Text("Buy an item")
							.font(.system(size: 25, weight: .heavy))
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
							.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
					}.padding()
					
					Form {
						Section(header: Text("Title")) {
							TextEditor(text: $item_vm.title)
						}
						.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						//						EntryFieldSignUp(placeHolder: "Title", prompt:item_vm.titlePrompt, field: $item_vm.title)
						//
						//						Spacer()
						
						Section(header: Text("Budget (USD)")) {
							TextField("$0.00", text: $item_vm.budget)
								.keyboardType(.decimalPad)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						Section {
							Picker("Category", selection: $item_vm.categorySelection) {
								ForEach(categoryList, id: \.self) {
									Text($0)
								}}
							
							Toggle(isOn: $item_vm.delivertRequest) {
								Text("Delivery request")
							}
						}.textCase(nil)
						.font(.system(size: 18))
						
						
						Section(header: Text("Zip code")) {
							TextField("12345", text: $item_vm.zipCode)
								.keyboardType(.numberPad)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
						
						Section(header: Text("Item description")) {
							TextEditor(text: $item_vm.description)
						}.textCase(nil)
						.font(.system(size: 18))
						.foregroundColor(.black)
					}.cornerRadius(15)
					.padding(.leading, 20)
					.padding(.trailing, 20)
					
					Button(action: {item_vm.createBuyPost();
					}
					, label: {
						Text("Post")
							.frame(width: 300, height: 50, alignment: .center)
							.font(.system(size: 25, weight: .heavy))
							.foregroundColor(.white)
							.background(Color(red: 128/255.0,
																green: 0/255.0,
																blue: 0/255.0, opacity: 1.0))
							.cornerRadius(15)
					})
					.padding(.vertical, 10)
					.padding(.horizontal, 50)
					.opacity(((!item_vm.title.isEmpty) && (!item_vm.description.isEmpty)) ? 1 : 0.6)
					.disabled((item_vm.title.isEmpty || item_vm.description.isEmpty))
					.alert(isPresented:$item_vm.availableStatus)
					{
						Alert(title: Text("Success"),
									message: Text("A buy post has been created!"),
									dismissButton: .default(Text("OK")))
					}
					//
					
				}//zstack
			}.navigationBarHidden(true)
		}
	}
	
	
}


struct CreateBuyView_Previews: PreviewProvider {
	static var previews: some View {
		CreateBuyView()
	}
}
