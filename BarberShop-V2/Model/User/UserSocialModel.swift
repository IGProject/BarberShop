//
//  UserSocialModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct UserSocial: Codable {
    var username:String?
    var email:String?
    var token:String?
    var user_id:String?
    var image:String?
    var type: UserType?
}
