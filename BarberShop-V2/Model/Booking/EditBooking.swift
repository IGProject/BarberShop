//
//  EditBooking.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct EditBooking: Codable {
    let booking_id: Int
    let user_id: Int
    let work_time: String
    let location_id:Locations
    let seva_id:Services
    let team_id:Teams
    let staus: Int
}
