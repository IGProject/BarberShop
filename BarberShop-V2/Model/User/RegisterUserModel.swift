//
//  UserEmailModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

struct SignUp:Codable {
    var username: String
    var email: String
    var phone: String
    var password: String
    var base64_image: String?
    var type: UserType.RawValue


  
  init(username:String,email:String,phone:String,password:String,base64_image:String,type: UserType) {
    self.username = username
    self.email = email
    self.phone = phone
    self.password = password
    self.base64_image = base64_image
    self.type = type.rawValue
  }
  
}
