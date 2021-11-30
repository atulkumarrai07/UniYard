import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class ItemDetailViewModel: ObservableObject {
  @State var chat:Chat = Chat(user1: MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: false), user2: MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: false), messages: [])
//  @State var postId:String = ""
  @Published var showBookmarkSelector = false
  
  func setPostId(postId:String) {
    getChatObject(postId: postId){chat in
      self.chat = chat
      print(chat)
      print(self.chat)
    }
  }
  
 func toggled(){
  self.showBookmarkSelector = !self.showBookmarkSelector
 }
  
  func getChatObject(postId:String, completion: @escaping (Chat)->Void){
    let auth = Auth.auth()
    let viewModel = ViewModel()
    viewModel.fetchMessageUser(userId: auth.currentUser!.uid){user1 in
      let currentUser = user1
      print(currentUser)//      print(self.postId)
      viewModel.fetchUserByPostId(postId: postId){user2 in
        let postUser = user2
        print(postUser)
        let chat = Chat(user1: currentUser, user2: postUser, messages: [])         // modification required to check for existing chat
        completion(chat)
      }
    }
  }

}
