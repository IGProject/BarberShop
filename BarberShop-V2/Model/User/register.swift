//
//  LoginUser.swift
//  BarberShop-V2
//
//  Created by User on 6/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct UserSocial:Decodable {
    let id:Int?
    let username:String
    let type:String
    let image:String?
    let token:String
    let user_id:String?
    let email:String?
    
}

struct UserEmail:Decodable {
    let id:Int?
    let phone:String?
    let token:String?
    let user_id:String?
    let username:String?
    let email:String?
    let image:String?
    let password:String?
    let user_type_id:Int?
}








