//
//  CancelBooking.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
struct CancelBooking: Codable {
    let booking_id: Int
    let user_reason: String
}
