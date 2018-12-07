//
//  BarberError.swift
//  BarberShop-V2
//
//  Created by User on 11/15/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct BarBerError: Codable {
  var httpStatusCode: String?
  var source:String?
  var messages:[String]?
  var innerExceptions: [String]?
  
  enum CodingKeys:String,CodingKey {
    case  httpStatusCode = "httpStatusCode"
    case source = "source"
    case messages = "message"
    case innerExceptions = "innerException"
  }
  
  
  
}
