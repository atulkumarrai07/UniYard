//
//  CreateBuyView.swift
//  Uniyard
//
//  Created by Iris Hao on 2021-10-27.
//

import SwiftUI

struct CreateBuyView: View {
	@Environment(\.presentationMode) var createBuyPresentation: Binding<PresentationMode>
	
	@StateObject var createBuy_vm = CreateBuyViewModel()
	
	var categoryList=["clothing", "books", "computers",
									 "electronics", "furniture", "home appliances", "jewelley, watches",
									 "music instruments", "phones", "sporting goods", "tools",
									 "toys, games", "other"]

	var body: some View {
		NavigationView {
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
						TextEditor(text: $createBuy_vm.title)
					}
					.textCase(nil)
					.font(.system(size: 15))
					.foregroundColor(.black)
					
					Section(header: Text("Budget (USD)")) {
						TextField("$0.00", text: $createBuy_vm.price)
							.keyboardType(.decimalPad)
					}.textCase(nil)
					.font(.system(size: 15))
					.foregroundColor(.black)
					
					Section {
						Picker("Category", selection: $createBuy_vm.categorySelection) {
							ForEach(categoryList, id: \.self) {
								Text($0)
							}}
							
							Toggle(isOn: $createBuy_vm.delivertRequest) {
								Text("Delivery request")
							}
						}
						
						
						Section(header: Text("Zip code")) {
							TextField("12345", text: $createBuy_vm.zipCode)
								.keyboardType(.numberPad)
						}.textCase(nil)
						.font(.system(size: 15))
						.foregroundColor(.black)
						
						Section(header: Text("Item description")) {
							TextEditor(text: $createBuy_vm.description)
						}.textCase(nil)
						.font(.system(size: 15))
						.foregroundColor(.black)
					}
					
					Button(action:{
						print("created!")
					}
					
					, label: {
						Text("Post")
							.frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
							.font(.system(size: 25, weight: .heavy))
							.foregroundColor(.white)
							.background(Color(red: 128/255.0,
																green: 0/255.0,
																blue: 0/255.0, opacity: 1.0))
							.cornerRadius(15)
						
					})
					
					.padding(.vertical, 10)
					.padding(.horizontal, 50)
					//					.disabled(!$createBuy_vm.isValid)
					.alert(isPresented:$createBuy_vm.showingAlert) {
						Alert(title: Text("Success"),
									message: Text("A buy post has been created!"),
									dismissButton: .default(Text("OK")))
					}
				}.navigationBarHidden(true)
			}
		}
		
		
	}
	
	
	struct CreateBuyView_Previews: PreviewProvider {
		static var previews: some View {
			CreateBuyView()
		}
	}
