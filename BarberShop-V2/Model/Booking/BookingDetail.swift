//
//  BookingModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation


struct BookingDetail: Decodable {
    
    let user_id: UserSocial
    let location_id:LocationDetail
    let team_id:TeamDetails
    let seva_id:ServicesDetails
    let work_time: String
}

