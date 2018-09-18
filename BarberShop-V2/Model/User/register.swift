//
//  LoginUser.swift
//  BarberShop-V2
//
//  Created by User on 6/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct UserSocialModel:Codable {
    let username:String?
    let email:String?
    let token:String?
    let user_id:String?
    let image:String?
    let type: UserType?
}

struct UserEmailModel:Codable {
  let f_name: String?
  let l_name: String?
  let sex: String?
  let username: String?
  let password: String?
  let base64_image: String?
  let type: UserType?
}

enum UserType: Int,Codable {
    case email
    case facebook
    case google
}





