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
    let location_id:LocationDetail
    let seva_id:ServicesDetails
    let team_id:TeamDetails
    let staus: Int
}
