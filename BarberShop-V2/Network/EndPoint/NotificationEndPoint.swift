//
//  NotificationEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/8/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

enum NotificationEndPoint: APIConfiguration {
  case listNotification
  case readNotification
  
  var method: HTTPMethod{
    switch self {
    case .listNotification:
      return .get
    case .readNotification:
      return .get
    }
  }
  
  var path: String{
    switch self {
      
    case .listNotification:
      return "notification/list"
    case .readNotification:
      return "notification/read_notification"
    }
  }
  
  var parameters: Parameters?{
    switch self {
      
    case .listNotification:
      return [:]
    case .readNotification:
      return [:]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
