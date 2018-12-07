//
//  TeamClientAPI.swift
//  BarberShop-V2
//
//  Created by User on 11/15/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

typealias ClientTeamAPICompletionBlock = (_ values:Any?,_ error:String?) -> Void

struct TeamClientAPI {
  func request(userEndPoint:TeamEndPoint,completion:@escaping ClientTeamAPICompletionBlock){
    var endpoint: UserEndpoint
    
    switch userEndPoint {
    case .getTeam: break
      
    }
}
}

