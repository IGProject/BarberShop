//
//  BookingModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation


struct BookingDetail: Codable {
    let user_id: Int
    let work_time: String
    let location_id:Int
    let service_id:Int
    let team_id:Int
  
  init(user_id:Int,work_time:String,location_id:Int,service_id:Int,team_id:Int) {
    self.user_id = user_id
    self.work_time = work_time
    self.location_id = location_id
    self.service_id = service_id
    self.team_id = team_id
  }
}

