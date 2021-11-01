//
//  BottomBarNav.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/28/21.
//

import SwiftUI

struct BottomBarNav: View {
  @State var selectedTab: Int = 5
  
    var body: some View {
      TabView(selection: $selectedTab){
        UniYardHomepage()
          .tabItem {
            Image(systemName: "house.fill")
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            Text("Home")
          }.tag(0)
        
        ChatView()
          .tabItem {
            Image(systemName: "message.fill")
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            Text("Chats")
          }.tag(1)
        
        SavedPostView()
          .tabItem {
            Image(systemName: "bookmark.fill")
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            Text("Saved Posts")
          }.tag(2)
        
        NotificationView()
          .tabItem {
            Image(systemName: "bell.fill")
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            Text("Notifications")
          }.tag(3)
        
        ProfileView()
          .tabItem {
            Image(systemName: "person.circle.fill")
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            Text("Profile")
          }.tag(4)
        
        
      }
    }
}

struct BottomBarNav_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarNav()
    }
}
