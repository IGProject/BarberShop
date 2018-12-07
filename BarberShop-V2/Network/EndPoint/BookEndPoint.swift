//
//  BookEndPoint.swift
//  BarberShop-V2
//
//  Created by User on 11/8/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire
enum BookingEndPoint: APIConfiguration {
  case bookItem(user_id:Int,work_time:String,location_id:Int,service_id:Int,team_id:Int)
  case cancelBooking(book_id:Int,user_reason:String)
  case editBooking(booking_id:Int,user_id:Int,work_time:String,location_id:Int,seva_id:Int,team_id:Int,status:Int)
  case transactionHistory()
  case appointment()
  var method: HTTPMethod{
    switch self {
    case .bookItem:
      return .post
    case .cancelBooking:
      return .post
    case .editBooking:
      return .post
    case .transactionHistory:
      return .post
    case .appointment:
      return .post
    }
  }
  
  var path: String{
    switch self {
    case .bookItem:
      return "bookItem/book"
    case .cancelBooking:
      return "bookItem/cancel"
    case .editBooking:
      return "bookItem/update"
    case .transactionHistory:
      return "bookItem/tranHistory"
    case .appointment:
      return "bookItem/appointment"
    }
  }
  
  var parameters: Parameters?{
    switch self{
      
    case .bookItem(_,_,_, _, _):
      return [:]
    case .cancelBooking(_,_):
      return [:]
    case .editBooking(_, _, _, _,_, _, _):
      return [:]
    case .transactionHistory:
      return [:]
    case .appointment:
      return [:]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Domains.BaseURL.asURL()
    return try BaseEndPoint.asURLRequest(url, path: path, method: method, parameters: parameters)
  }
  
  
}
