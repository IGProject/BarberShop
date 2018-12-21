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
    let location_id:Int
    let seva_id:Int
    let team_id:Int
    let status: Bool
  
  init(booking_id:Int,user_id:Int,work_time:String,location_id:Int,seva_id:Int,team_id:Int,status:Bool) {
    self.booking_id = booking_id
    self.user_id = user_id
    self.work_time = work_time
    self.location_id = location_id
    self.seva_id = seva_id
    self.team_id = team_id
    self.status = status
  }
}
