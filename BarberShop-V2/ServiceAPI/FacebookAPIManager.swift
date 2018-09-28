//
//  FacebookAPIManager.swift
//  BarberShop-V2
//
//  Created by User on 9/25/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

let kGraphPathMe = "me"
let kGraphPathMePaageLikes = "me/likes"
let param = ["fields":"id,email,last_name,first_name,picture"]
class FacebookAPIManger {
    let accessToken: AccessToken
   // let networkingManager =
    
    init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }
    
//    func requestFacebookUser(completion: @escaping (_ facebookUser: UserSocial) -> Void) {
//        let graphRequest = GraphRequest(graphPath: kGraphPathMe, parameters: param, accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)
//        graphRequest.start { (response:HTTPURLResponse?, result:GraphRequestResult<GraphRequest>) in
//            switch result {
//            case .success(let graphResponse):
//                if let dictionary = graphResponse.dictionaryValue {
//                    
//                }
//            break
//            default:
//                print("Facebook request user error")
//            }
//        }
//        
//    }
}
