//
//  ItemDetailViewModel.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/28/21.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class ItemDetailViewModel: ObservableObject {
  @Published var showBookmarkSelector = false
  

  func toggled(){
    self.showBookmarkSelector = !self.showBookmarkSelector
  }
}
