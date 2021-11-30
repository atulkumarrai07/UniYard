//
//  SavedPostViewModel.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 11/20/21.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class SavedPostViewModel: ObservableObject {
  @StateObject var itemsViewModel = ItemsViewModel()
  
  var viewModel = ViewModel()
  private let database = Firestore.firestore()
  var savedPostsArray:[String] = []
  @Published var savedPostfilteredItems:[PostItem] = []
  @Published var isEmptySavePostList: Bool = false
  @Published var savedPostsForCurrentUser:[String] = []
  
  func loadSavedPosts() {
    
    let auth = Auth.auth()
    let user_id = auth.currentUser?.uid
    viewModel.fetchSavedPost(userId: user_id ?? "nil") { results in
      self.savedPostsArray = results
//      print(self.savedPostsArray.count)
      if(self.savedPostsArray.isEmpty)
      {
        self.isEmptySavePostList = true
      }
      else
      {
      self.isEmptySavePostList = false
      
      
      self.savedPostfilteredItems = []
      self.viewModel.fetchAllSavedPosts(savePostArray: self.savedPostsArray) { result in
        self.savedPostfilteredItems = result
        self.updateSaveStatus()
      }
    }
  }
}
  func updateSaveStatus() {
    let auth = Auth.auth()
    let user_id = auth.currentUser?.uid
    viewModel.fetchSavedPost(userId: user_id!) { results in
      self.savedPostsForCurrentUser = results
      
      if(!self.savedPostsForCurrentUser.isEmpty)
      {
        for postId in self.savedPostsForCurrentUser{
            if let row = self.savedPostfilteredItems.firstIndex(where: {$0.postId == postId}){
            self.savedPostfilteredItems[row].isSaved = true
          }
        }
      }
    }
  }
  func deleteFromSavePost(postId: String){
    let auth = Auth.auth()
    let user_id = auth.currentUser?.uid
      let updateReference = database.collection("Users").document(user_id!)
      updateReference.getDocument { (document, err) in
        if let err = err {
          print(err.localizedDescription)
        }
        else {
          document?.reference.updateData([
            "saved_post_list": FieldValue.arrayRemove([postId])
          ])
        }
      }
    }
  func checkIfSaved(postId: String) -> Bool
  {
    if(self.savedPostsArray.contains(postId))
    {
      return true
    }
    else
    {
      return false
    }
  }
}
