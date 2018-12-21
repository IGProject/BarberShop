//
//  SignInSocialResponse.swift
//  BarberShop-V2
//
//  Created by User on 12/17/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
struct UserSocialResponse: Codable {
  let response: Bool
  let notificationCount: Int
  let userData: UserData
  
  enum CodingKeys: String, CodingKey {
    case response
    case notificationCount = "notification_count"
    case userData = "user_data"
  }
}

struct UserData: Codable {
  let id: Int
  let userID, username, image, token: String
  let email: String
  let type: Int
  let userToken: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case userID = "user_id"
    case username, image, token, email, type
    case userToken = "user_token"
  }
}
