//
//  UniyardApp.swift
//  Uniyard
//
//  Created by Atul Kumar Rai on 10/13/21.
//

import SwiftUI
import Firebase

@main
struct UniyardApp: App {
  init() {
    FirebaseApp.configure()
  }
    var body: some Scene {
        WindowGroup {
//            ContentView()
          Login()
        }
    }
}
