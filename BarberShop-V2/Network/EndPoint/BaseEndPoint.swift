//
//  BaseEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/7/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Alamofire
struct BaseEndPoint {
  static func asURLRequest(_ url:URL,path:String,method: HTTPMethod,parameters:Parameters?) throws -> URLRequest {
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    //HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    urlRequest.timeoutInterval = 15.0 // Request timeout for 15 seconds
    
    // Common Headers
    urlRequest.setValue(Domains.ContentType.json.rawValue, forHTTPHeaderField: Domains.HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(Domains.ContentType.json.rawValue, forHTTPHeaderField: Domains.HTTPHeaderField.contentType.rawValue)
    
    // Parameters
    if let parameters = parameters  {
      do {
        
        let json = try JSONSerialization.data(withJSONObject: parameters, options: [])
        urlRequest.httpBody = json
      }  catch  {
        throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
      }
    }
    
    return urlRequest
  }
  
}
