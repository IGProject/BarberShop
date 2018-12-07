//
//  UserResponse.swift
//  BarberShop-V2
//
//  Created by User on 11/20/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct UserResponse:Codable {
  var booking: [String]
  var response: String
  var user_token: String
  var notification_count: Int
  var user_profile:[ProfileImage]
  var message: String
}

struct ProfileImage: Codable {
  let id: Int
  let username: String
  let profile_image: String?
}
