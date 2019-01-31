//
//  URLConstant.swift
//  BarberShop-V2
//
//  Created by User on 11/7/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
struct Domains {
  
  //static let Dev = "http://192.168.2.247"
  //static let Dev = "http://96.9.66.134:154"
  static let Dev = "https://dev.idealinkconsulting.com"
  
  private struct Routes {
     //static let api = ":8090"
    static let api = "/BarberShopRest"
  }
  
   static let Domain = Domains.Dev
   static let Route = Routes.api
   static let BaseURL = Domain + Route
  
 
  
  

  enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
  }
  
  enum ContentType: String {
    case json = "application/json"
  }
}
