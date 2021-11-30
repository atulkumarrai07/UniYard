//
//  SaveChat.swift
//  Uniyard
//
//  Created by Atul Kumar Rai on 11/23/21.
//

import Foundation

struct SaveChat: Codable, Identifiable, Hashable{
  var id = UUID().uuidString
  var user1:String
  var user2:String
  var messages:[String]
  var hasUnreadMessage = false
  
  enum CodingKeys: String, CodingKey {
//    case post_id
    case user1
    case user2
    case messages
    case hasUnreadMessage
  }
  
  var dictionary: [String: Any] {
          let data = (try? JSONEncoder().encode(self)) ?? Data()
          return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
  }
  
}
