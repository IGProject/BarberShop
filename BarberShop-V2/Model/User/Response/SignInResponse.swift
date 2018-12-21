//
//  SignInResponse.swift
//  BarberShop-V2
//
//  Created by User on 12/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
  let booking: [Booking]
  let response, userToken: String
  let userProfile: [UserProfile]
  let notificationCount: Int
  
  enum CodingKeys: String, CodingKey {
    case booking, response
    case userToken = "user_token"
    case userProfile = "user_profile"
    case notificationCount = "notification_count"
  }
  
}
