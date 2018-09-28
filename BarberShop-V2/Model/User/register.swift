//
//  LoginUser.swift
//  BarberShop-V2
//
//  Created by User on 6/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import FacebookCore

struct FacebookUser:GraphRequestProtocol {
    
    var graphPath: String = "/me"
    var parameters: [String : Any]? = ["fields":"id,email, name"]
    var accessToken: AccessToken? = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
    
    struct Response: GraphResponseProtocol {
        var username:String?
        var email:String?
        var token:String?
        var user_id:String?
        var image:String?
        var type: UserType?
        init(rawResponse: Any?) {
            if let dict = rawResponse as? [String:Any]{
                self.username = (dict["name"] as? String)!
                self.email = (dict["email"] as? String)!
                self.user_id = (dict["id"] as? String)!
            }
        }
        
        
    }
}

struct UserEmail:Codable {
  let f_name: String
  let l_name: String
  let sex: String
  let username: String
  let password: String
  let base64_image: String
  let type: UserType
}

enum UserType: Int,Codable {
    case email
    case facebook
    case google
}





