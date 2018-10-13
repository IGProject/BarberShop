//
//  LoginUser.swift
//  BarberShop-V2
//
//  Created by User on 6/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

enum UserType: Int,Codable {
    case admin
    case email
    case facebook
    case google
    
    static func get(from: Int) -> UserType {
        if from == email.rawValue {
            return .email
        }else if from == facebook.rawValue {
            return .facebook
        }else if from == google.rawValue {
            return .google
        }
        return .admin
    }
}







