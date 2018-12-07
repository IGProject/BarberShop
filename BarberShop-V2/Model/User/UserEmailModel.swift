//
//  UserEmailModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct RegisterModel:Codable {
    var username: String
    var email: String
    var phone: String
    var password: String
    var base64_image: String?
    var type: UserType.RawValue
  
    
}
