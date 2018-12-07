//
//  RegisterResponse.swift
//  BarberShop-V2
//
//  Created by User on 12/5/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct RegisterResponse: Codable {
  let booking: [BookingResponse]?
  let response, userToken: String
  let notificationCount: Int
  let userProfile: [UserProfile]
  let message: String
  
  enum CodingKeys: String, CodingKey {
    case booking, response
    case userToken = "user_token"
    case notificationCount = "notification_count"
    case userProfile = "user_profile"
    case message
  }
}

struct UserProfile: Codable {
  let id: Int
  let username: String
  let profileImage: String?
  
  enum CodingKeys: String, CodingKey {
    case id, username
    case profileImage = "profile_image"
  }
}

