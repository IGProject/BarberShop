//
//  CancelBookingResponse.swift
//  BarberShop-V2
//
//  Created by User on 12/14/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct CancelBookingResponse: Codable {
  let book_id:Int
  let user_reason:String
}
