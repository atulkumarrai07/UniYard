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
