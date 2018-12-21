//
//  LoginUser.swift
//  BarberShop-V2
//
//  Created by User on 6/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

enum UserType: Int,Codable {
    case admin = 1
    case email = 2
    case facebook = 3
    case google = 4
    
    static func get(from: Int) -> UserType? {
      switch from {
      case admin.rawValue:
        return .admin
      case email.rawValue:
        return .email
      case facebook.rawValue:
        return .facebook
      case google.rawValue:
        return .google
      default:
        return nil
      }
    }
}







