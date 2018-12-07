//
//  ServiceEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/8/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceEndPoint: APIConfiguration {
  
  case getService
  
  var method: HTTPMethod{
    switch self {
    case .getService:
      return .get
    }
  }
  
  var path: String{
    switch self {
      
    case .getService:
      return "seva/list"
    }
  }
  
  var parameters: Parameters?{
    switch self {
    case .getService:
      return [:]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
