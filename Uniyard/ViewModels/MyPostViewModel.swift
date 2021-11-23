import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class MyPostViewModel: ObservableObject {
  @StateObject var itemsViewModel = ItemsViewModel()
  
  var viewModel = ViewModel()
  private let database = Firestore.firestore()
  var myPostsArray:[String] = []
  @Published var myPostfilteredItems:[PostItem] = []
  @Published var isEmptyMyPostList: Bool = false
  @Published var myPostsForCurrentUser:[String] = []
  
  func loadMyPosts() {
    let auth = Auth.auth()
    let user_id = auth.currentUser?.uid
    viewModel.fetchMyPost(userId: user_id!) { results in
      self.myPostsArray = results
      
      if(self.myPostsArray.isEmpty)
      {
        self.isEmptyMyPostList = true
      }
      else
      {
      self.isEmptyMyPostList = false
      self.myPostfilteredItems = []
      self.viewModel.fetchAllMyPosts(myPostArray: self.myPostsArray) { result in
        self.myPostfilteredItems = result
//        self.updateSaveStatus()
      }
    }
  }
}
//  func updateSaveStatus() {
//    let auth = Auth.auth()
//    let user_id = auth.currentUser?.uid
//    viewModel.fetchSavedPost(userId: user_id!) { results in
//      self.savedPostsForCurrentUser = results
//
//      if(!self.savedPostsForCurrentUser.isEmpty)
//      {
//        for postId in self.savedPostsForCurrentUser{
//            if let row = self.savedPostfilteredItems.firstIndex(where: {$0.postId == postId}){
//            self.savedPostfilteredItems[row].isSaved = true
//          }
//        }
//      }
//    }
//  }
  func deleteFromMyPost(postId: String){
    let auth = Auth.auth()
    let user_id = auth.currentUser?.uid
      let updateReference = database.collection("Users").document(user_id!)
      updateReference.getDocument { (document, err) in
        if let err = err {
          print(err.localizedDescription)
        }
        else {
          document?.reference.updateData([
            "my_post_list": FieldValue.arrayRemove([postId])
          ])
        }
      }
    }
//  func checkIfSaved(postId: String) -> Bool
//  {
//    if(self.savedPostsArray.contains(postId))
//    {
//      return true
//    }
//    else
//    {
//      return false
//    }
//  }
}

