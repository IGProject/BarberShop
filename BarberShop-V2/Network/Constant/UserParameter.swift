//
//  UserParameter.swift
//  BarberShop-V2
//
//  Created by User on 11/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

enum UserAPIParameters{
  enum Request {
    enum Register: String {
      case r_username = "username"
      case r_email = "email"
      case r_phone = "phone"
      case r_password = "password"
      case r_base64_image = "base64_image"
      case r_type = "type"
    }
  }
  
  enum Response {
    enum Register: String {
      case r_user_token = "user_token"
      case r_notification_count = "notification_count"
    }
  }
}

