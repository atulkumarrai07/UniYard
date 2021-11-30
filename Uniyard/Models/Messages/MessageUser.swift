//
//  MessageUser.swift
//  Uniyard
//
//  Created by Atul Kumar Rai on 11/22/21.
//

import Foundation

struct MessageUser: Identifiable, Codable, Hashable{
  var id:String 
  var user_image:String
  var first_name:String
  var last_name:String
  var user_status:Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case user_image
    case first_name
    case last_name
    case user_status
  }
}
