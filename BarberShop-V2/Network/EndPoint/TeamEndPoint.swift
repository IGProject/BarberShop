//
//  TeamEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/8/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

enum TeamEndPoint: APIConfiguration {
  case getTeam
  var method: HTTPMethod{
    switch self {
    case .getTeam:
      return .get
    }
  }
  
  var path: String{
    switch self {
      
    case .getTeam:
      return "team/list"
    }
  }
  
  var parameters: Parameters?{
    switch self {
    case .getTeam:
      return nil
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
