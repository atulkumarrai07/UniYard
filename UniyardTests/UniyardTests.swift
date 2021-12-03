//
//  UniyardTests.swift
//  UniyardTests
//
//  Created by Atul Kumar Rai on 10/13/21.
//

import XCTest
@testable import Uniyard
import FirebaseFirestore

class UniyardTest: XCTestCase {
  
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
  
//  func testClearAllDataForTestUser(){
//    let expectationTestClearAllDataForTestUser = self.expectation(description: "testClearAllDataForTestUser")
//    var deletedFlag = false
//    // delete test user from Users table
//    database.collection("Users").whereField("email", isEqualTo: "test@andrew.cmu.edu").getDocuments() { (querySnapshot, err) in
//      if let err = err {
//          print("Error getting documents: \(err)")
//      } else {
//          for document in querySnapshot!.documents {
//            self.userId = document.documentID
//          }
//      }
//      self.database.collection("Users").document(self.userId).delete() { err in
//          if let err = err {
//              print("Error removing document: \(err)")
//          } else {
//              deletedFlag = true
//          }
//        expectationTestClearAllDataForTestUser.fulfill()
//      }
//    }
//    wait(for: [expectationTestClearAllDataForTestUser], timeout: 7.0)
//    XCTAssertEqual(deletedFlag, true)
//  }
  
//  func testEmailAddressEntered() {
//    let user = User(email: "sara@andrew.cmu.edu", password: "Sara1234", user_image: "", first_name: "Sara", last_name: "Gomez", campus_location: "Pittsburgh", saved_post_list: <#T##[String]#>, my_post_list: <#T##[String]#>, date_joined: Timestamp, suggestion_preference: "Any", user_status: true)
//
//  }

//  var viewModel: SignUpViewModel!
//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//      viewModel = .init()
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
