//
//  ProductEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/8/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

enum ProductEndPoint:APIConfiguration {
  
  case getProduct
  var method: HTTPMethod{
    switch self{
    case .getProduct:
      return .get
    }
  }
  
  var path: String{
    switch self {
    case .getProduct:
      return "product/list"
    }
  }
  
  var parameters: Parameters?{
    switch self {
    case .getProduct:
      return [:]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
