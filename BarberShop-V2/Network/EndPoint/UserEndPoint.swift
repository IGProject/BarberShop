//
//  UserEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/7/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

enum UserEndpoint: APIConfiguration {
  
  case login(parameter: Parameters)
  case compareToken(parameter:Parameters)
  case registerUser(parameter:Parameters)
  case registerSocialUser(parameter:Parameters)
  case getAwardPoint


  
  
  
  //MARK: HTTPMethod
  var method: HTTPMethod {
    switch self {
    case .login:
      return .post
    case .compareToken:
      return .post
    case .registerUser:
      return .post
    case .registerSocialUser:
      return .post
    case .getAwardPoint:
      return .get
    }
  }
  
  //MARK: -Path
  var path: String {
    switch self {
    case .login:
      return "user/login"
    case .compareToken:
      return "user/tokenCheck"
    case .registerUser:
      return "user/register"
    case .registerSocialUser:
      return "user/socialRegister"
    case .getAwardPoint:
      return "user/getPoint"
    }
  }
  
  
  var parameters: Parameters?{
    switch self {
    case .login(let parameter):
      return parameter
    case .compareToken(let parameter):
      return parameter
    case .registerUser(let parameter):
      return parameter
    case .registerSocialUser(let parameter):
      return parameter
    case .getAwardPoint:
      return nil
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
