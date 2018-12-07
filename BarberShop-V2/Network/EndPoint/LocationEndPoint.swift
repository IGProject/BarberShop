//
//  locationEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/8/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

enum LocationEndPoint: APIConfiguration {
  
  case getLocation
  case findNearBy
  
  var method: HTTPMethod{
    switch self {
      
    case .getLocation:
      return .get
    case .findNearBy:
      return .get
    }
  }
  
  var path: String{
    switch self {
    case .getLocation:
      return ""
    case .findNearBy:
      return ""
    }
  }
  
  var parameters: Parameters?{
    switch self {
    case .getLocation:
      return nil
    case .findNearBy:
      return nil
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
