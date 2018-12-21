//
//  UserSocialModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct UserSocial: Codable {
    var username:String
    var email:String
    var token:String
    var user_id:String
    var image:String
    var type: UserType.RawValue
  
  init(username:String,email:String,token:String,user_id:String,image:String,type:UserType) {
       self.username = username
       self.email = email
       self.token = token
       self.user_id = user_id
       self.image = image
       self.type = type.rawValue
    
  }
}
