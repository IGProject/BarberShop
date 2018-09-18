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
    let location_id:LocationDetail
    let service_id:ServicesDetails
    let team_id:TeamDetails    
}

