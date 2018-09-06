//
//  LocationModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct LocationDetail: Decodable {
    let id: Int?
    let address: String?
    let phone: String?
    let work_time:String?
    let latitude: String?
    let longitude: String?
    let location_profile: String?
    let team: [TeamDetails]?
    
    
}

struct TypeLocation {
    let type: String
    let belonging:[String]
}

