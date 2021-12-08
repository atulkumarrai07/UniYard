
import XCTest
@testable import Uniyard
import FirebaseFirestore

class UniyardTest: XCTestCase {
  
  // Before running unit test make sure that user with email id: test@andrew.cmu.edu does not exist in Users collection
  // and Firestore authentication. If it does exist, run the last test to remove the user from both these locations
  
  // In addition to this all the test cases must run from top to bottom sequentially and one at a time
  
  let signupViewModel = SignUpViewModel()
  let loginViewModel = LoginModel()
  let itemsViewModel = ItemsViewModel()
  let database = Firestore.firestore()
  var userId:String = ""
  var postIds:[String] = []
  var itemIds:[String] = []
  var chatIds:[String] = []
  var messageIds:[String] = []
  
  // SignUpViewModel Test case
  func testSignup() throws {
    let expectationTestSignup = self.expectation(description: "testSignup")
    signupViewModel.cmu_email = "test@andrew.cmu.edu"
    signupViewModel.first_name = "test"
    signupViewModel.last_name = "test"
    signupViewModel.password = "Test1234"
    signupViewModel.confirm_password = "Test1234"
    signupViewModel.showingAlert = false
    signupViewModel.campus_location = "Pittsburgh"
    signupViewModel.showTCSelector = false
    signupViewModel.toggled()
    XCTAssertEqual(signupViewModel.showTCSelector, true)        // testing for toggle functionality
    XCTAssertEqual(signupViewModel.passwordMatch(), true)       // testing for password match functionality
    signupViewModel.signUp(email: signupViewModel.cmu_email, password: signupViewModel.password)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationTestSignup.fulfill()
    }
    wait(for: [expectationTestSignup], timeout: 5.0)
    XCTAssertEqual(signupViewModel.registrationStatus, true)
  }
  
  // loginViewModel Test case
  func testLogin() throws {
    let expectationLogin = self.expectation(description: "login")
    loginViewModel.login(email: "test@andrew.cmu.edu", password: "Test1234")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationLogin.fulfill()
    }
    wait(for: [expectationLogin], timeout: 5.0)
    XCTAssertEqual(loginViewModel.signedIn, true)
  }
  
  // ItemDetailsViewModel Test case
  func testLoadItemsWithPostAvailable() throws {
    let expectationtestLoadItemsWithPostAvailable = self.expectation(description: "testLoadItemsWithPostAvailable")
    itemsViewModel.loadItemswithPostsAvailable()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationtestLoadItemsWithPostAvailable.fulfill()
    }
    wait(for: [expectationtestLoadItemsWithPostAvailable], timeout: 5.0)
    XCTAssertGreaterThan(itemsViewModel.itemswithPostsAvailableArray.count, 0)
  }
  
  // Make sure once the password is changes change the same while executing the login unit tests
  
  // CurUserViewModel Test case
  func testUpdatePwd() throws {
    let curUserViewModel = CurUserViewModel()
    let expectationLoginAfterUpdatePassword = self.expectation(description: "update password")
    curUserViewModel.updatePwd("Test1234")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
    }
    loginViewModel.login(email: "test@andrew.cmu.edu", password: "Test1234")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationLoginAfterUpdatePassword.fulfill()
    }
    wait(for: [expectationLoginAfterUpdatePassword], timeout: 5.0)
    XCTAssertEqual(loginViewModel.signedIn, true)
  }
  
  // CurUserViewModel Test case
  func testUpdateLocation() throws {
    var currentLocation:String = ""
    var newLocation:String = ""
    var curUserViewModel = CurUserViewModel()
    let expectationUpdateLocation = self.expectation(description: "update location")
    currentLocation = curUserViewModel.campus_location
    if(currentLocation != "Pittsburgh"){
      newLocation = "Pittsburgh"
    }
    else{
      newLocation = "Qatar"
    }
    curUserViewModel.updateLocation(newLocation)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      
    }
    curUserViewModel = CurUserViewModel()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationUpdateLocation.fulfill()
    }
    wait(for: [expectationUpdateLocation], timeout: 5.0)
    XCTAssertEqual(curUserViewModel.campus_location, newLocation)
  }
  
  // CurUserViewModel Test case
  func testUpdateNotification() throws {
    var currentNotification_preference:Bool = false
    var newNotification_preference:Bool = false
    var curUserViewModel = CurUserViewModel()
    let expectationUpdateNotificationPreference = self.expectation(description: "update notification preference")
    currentNotification_preference = curUserViewModel.notification_preference
    if(currentNotification_preference != false){
      newNotification_preference = true
    }
    else{
      newNotification_preference = false
    }
    curUserViewModel.updateNotification(newNotification_preference)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      
    }
    curUserViewModel = CurUserViewModel()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationUpdateNotificationPreference.fulfill()
    }
    wait(for: [expectationUpdateNotificationPreference], timeout: 5.0)
    XCTAssertEqual(curUserViewModel.notification_preference, newNotification_preference)
  }
  
  // CurUserViewModel Test case
  func testConvertTimestamp() throws {
    let curUserViewModel = CurUserViewModel()
    let result = curUserViewModel.convertTimestamp(serverTimestamp: Date())
    XCTAssertNotNil(result)
  }
  
  // ItemDetailsViewModel
  func testGetChatObject() throws {
    let expectationGetChatObject = self.expectation(description: "get chat object")
    let itemDetailViewModel = ItemDetailViewModel()
    itemDetailViewModel.setPostId(postId:"P00001")
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
      expectationGetChatObject.fulfill()
    }
    wait(for: [expectationGetChatObject], timeout: 7.0)
    XCTAssertEqual(itemDetailViewModel.chat.user1.first_name, "test")
  }
  
  // ItemViewModel
  func testLoadItemswithPostsAvailable() throws {
    let itemsViewModel = ItemsViewModel()
    let expectationLoadItemswithPostsAvailable = self.expectation(description: "LoadItemswithPostsAvailable")
    itemsViewModel.loadItemswithPostsAvailable()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationLoadItemswithPostsAvailable.fulfill()
    }
    wait(for: [expectationLoadItemswithPostsAvailable], timeout: 5.0)
    XCTAssertNotNil(itemsViewModel.itemswithPostsAvailableArray)
  }
  
  // ItemDetailsViewModel
  func testToggled() throws {
    let itemDetailViewModel = ItemDetailViewModel()
    let currentStateOfBookMark = itemDetailViewModel.showBookmarkSelector
    itemDetailViewModel.toggled()
    XCTAssertEqual(itemDetailViewModel.showBookmarkSelector, !currentStateOfBookMark)
  }
  
  // ChatsViewModel
  func testRefreshChats() throws {
    let expectationRefreshChats = self.expectation(description: "refresh chats")
    let chatViewModel = ChatsViewModel()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      
    }
    chatViewModel.refreshChats()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationRefreshChats.fulfill()
    }
    wait(for: [expectationRefreshChats], timeout: 8.0)
    XCTAssertNotNil(chatViewModel.chats)
  }
  
  // ChatsViewModel
  func testGetSectionMessages() throws {
    let expectationGetSectionMessages = self.expectation(description: "refresh chats")
    let chatViewModel = ChatsViewModel()
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
      expectationGetSectionMessages.fulfill()
    }
    wait(for: [expectationGetSectionMessages], timeout: 7.0)
    XCTAssertNotNil(chatViewModel.getSectionMessages(for: Chat(user1: MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: false), user2: MessageUser(id: "", user_image: "", first_name: "", last_name: "", user_status: false), messages: [])))
  }
  
  // SavedPostViewModel
  func testLoadSavedPost() throws {
    let savedPostViewModel = SavedPostViewModel()
    let expectationLoadSavedPost = self.expectation(description: "LoadSavedPost")
    savedPostViewModel.loadSavedPosts()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationLoadSavedPost.fulfill()
    }
    wait(for: [expectationLoadSavedPost], timeout: 5.0)
    XCTAssertNotNil(savedPostViewModel.savedPostfilteredItems)
  }
  
  // SavedPostViewModel
  func testCheckIfPostIsSaved() throws {
    let savedPostViewModel = SavedPostViewModel()
    let expectationCheckIfPostIsSaved = self.expectation(description: "CheckIfPostIsSaved")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationCheckIfPostIsSaved.fulfill()
    }
    wait(for: [expectationCheckIfPostIsSaved], timeout: 5.0)
    XCTAssertEqual(savedPostViewModel.checkIfSaved(postId: "P00001"), false)
  }
  
  // MyPostViewModel
  func testLoadMyPost() throws {
    let myPostViewModel = MyPostViewModel()
    let expectationLoadMyPost = self.expectation(description: "myPostViewModel")
    myPostViewModel.loadMyPosts()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationLoadMyPost.fulfill()
    }
    wait(for: [expectationLoadMyPost], timeout: 5.0)
    XCTAssertNotNil(myPostViewModel.myPostfilteredItems)
  }
  
  
  
  // loginViewModel Test case
  func testSignOut() throws {
    let expectationSignout = self.expectation(description: "signout")
    loginViewModel.signOut()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationSignout.fulfill()
    }
    wait(for: [expectationSignout], timeout: 5.0)
    XCTAssertEqual(loginViewModel.signedIn, false)
  }
  
  func testClearAllDataForTestUser(){
    let expectationTestClearAllDataForTestUser = self.expectation(description: "testClearAllDataForTestUser")
    var deletedFlag = false
    // delete test user from Users table
    database.collection("Users").whereField("email", isEqualTo: "test@andrew.cmu.edu").getDocuments() { (querySnapshot, err) in
      if let err = err {
          print("Error getting documents: \(err)")
      } else {
          for document in querySnapshot!.documents {
            self.userId = document.documentID
          }
      }
      self.database.collection("Users").document(self.userId).delete() { err in
          if let err = err {
              print("Error removing document: \(err)")
          } else {
              deletedFlag = true
          }
        expectationTestClearAllDataForTestUser.fulfill()
      }
    }
    wait(for: [expectationTestClearAllDataForTestUser], timeout: 7.0)
    XCTAssertEqual(deletedFlag, true)
  }

}
