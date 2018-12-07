//
//  APIConfiguration.swift
//  BarberShop-V2
//
//  Created by User on 11/7/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
  var method: HTTPMethod {get}
  var path: String {get}
  var parameters: Parameters? {get}
}
