//
//  SignInEmailModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
struct SignInEmail: Codable {
    var username: String
    var password: String
    var token: String
  
  init(username: String,password:String,token:String) {
    self.username = username
    self.password = password
    self.token = token
  }
 
}
