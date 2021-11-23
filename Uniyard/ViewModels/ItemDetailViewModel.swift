import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth
class ItemDetailViewModel: ObservableObject {
// @Published var post: PostItem
 @Published var showBookmarkSelector = false
  
 func toggled(){
  self.showBookmarkSelector = !self.showBookmarkSelector
//  self.post.isSaved = !self.post.isSaved
 }
}
