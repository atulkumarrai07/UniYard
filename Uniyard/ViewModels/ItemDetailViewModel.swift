import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class ItemDetailViewModel: ObservableObject {
  @Published var chat:Chat = Chat(user1: MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: false), user2: MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: false), messages: [])
//  @State var postId:String = ""
  @Published var showBookmarkSelector = false
  
  func setPostId(postId:String) {
    getChatObject(postId: postId){chat in
      self.chat = chat
    }
  }
  
 func toggled(){
  self.showBookmarkSelector = !self.showBookmarkSelector
 }
  
  func getChatObject(postId:String, completion: @escaping (Chat)->Void){
    var flagFound = false
    let auth = Auth.auth()
    let viewModel = ViewModel()
    viewModel.fetchMessageUser(userId: auth.currentUser!.uid){user1 in
      let currentUser = user1
      viewModel.fetchUserByPostId(postId: postId){user2 in
        let postUser = user2
        viewModel.fetchChats(currentUserID: auth.currentUser!.uid){results in
          let chats = results
//          let existingChat = chats.first(where: {$0.user2 == self.chat.user2})
          for chat in chats{
            if(chat.user2.id == postUser.id){
              flagFound = true
              completion(chat)
            }
          }
          if(!flagFound){
            let chat = Chat(user1: currentUser, user2: postUser, messages: [])
            completion(chat)
          }
        }
      }
    }
  }

}
