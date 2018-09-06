//
//  LoginUser.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
struct SigninEmailModel: Decodable {
    var email: String
    var password: String
    
     init(email:String,password:String){
        self.email = email
        self.password = password
    }
    
    func isValid() -> Bool {
        return email != "" && password != ""
    }
}


struct SigninSocialModel: Decodable {
    var email: String
    var token: String
}
