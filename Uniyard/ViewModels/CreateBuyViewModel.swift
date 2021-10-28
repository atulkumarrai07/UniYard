//
//  CreateBuyView.swift
//  Uniyard
//
//  Created by Iris Hao on 2021-10-27.
//

import SwiftUI
import Combine
import FirebaseFirestore

class CreateBuyViewModel: ObservableObject {
	@Published var title = ""
	
	@Published var price = ""
	@Published var delivertRequest = false
	@Published var zipCode = ""
	@Published var description = ""
	
	@Published var showingAlert = false
	@Published var isValid = false
	
	@Published var categorySelection = "clothing"
	
	private var cancellableSet: Set<AnyCancellable> = []
	
	init() {
		$title.map{title in
					return !self.title.isEmpty
				}.assign(to: \.isValid, on: self).store(in: &cancellableSet)
	}
	
	func toggled(){
		var titlePrompt: String {
				(!title.isEmpty) ? "" : "Post title cannot be empty"
			}
	}
	
	func createBuyPost(title: String, categorySelection:String, price: String, delivertRequest: Bool,
										 zipCode: String, description: String ){
		
	
	}
}
