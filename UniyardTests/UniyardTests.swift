//
//  UniyardTests.swift
//  UniyardTests
//
//  Created by Atul Kumar Rai on 10/13/21.
//

import XCTest
@testable import Uniyard

class UniyardTest: XCTestCase {
  
  let signupViewModel = SignUpViewModel()
  let loginViewModel = LoginModel()
  let itemsViewModel = ItemsViewModel()
  var userId:String = ""
  var postId:String = ""
  var itemId:String = ""
  var chatIdForTestUser:[String] = []
  var messageIdsForTestUer:[String] = []
  
  func testSignup() throws {
    signupViewModel.cmu_email = "test@andrew.cmu.edu"
    signupViewModel.first_name = "test"
    signupViewModel.last_name = "test"
    signupViewModel.password = "test"
    signupViewModel.confirm_password = "test"
    signupViewModel.showingAlert = false
    signupViewModel.campus_location = "Pittsburgh"
    
    
  }
  
  // loginViewModel Test case
  func testLogin() throws {
    let expectationLogin = self.expectation(description: "login")
    loginViewModel.login(email: "atulkumr@andrew.cmu.edu", password: "Atul1234")
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationLogin.fulfill()
    }
    wait(for: [expectationLogin], timeout: 5.0)
    XCTAssertEqual(loginViewModel.signedIn, true)
  }
  
  // itemDetailsViewModel Test case
  func testLoadItemsWithPostAvailable() throws {
    let expectationtestLoadItemsWithPostAvailable = self.expectation(description: "testLoadItemsWithPostAvailable")
    itemsViewModel.loadItemswithPostsAvailable()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      expectationtestLoadItemsWithPostAvailable.fulfill()
    }
    wait(for: [expectationtestLoadItemsWithPostAvailable], timeout: 5.0)
    XCTAssertGreaterThan(itemsViewModel.itemswithPostsAvailableArray.count, 0)
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
  
  func clearAllDataForUser(){
    
  }
  
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
