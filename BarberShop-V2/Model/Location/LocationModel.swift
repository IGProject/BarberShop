//
//  LocationModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct Locations: Codable {
  let length:Int
    struct Results: Codable {
        let id:Int
        let address: String
        let phone: String
        let work_time: String
        let longitude: String
        let latitude: String
        let location_profile: String
        let team:[Teams]
    }
    struct Teams: Codable{
        let id: Int
        let username: String
        let team_profile: String
    }
  
    var results:[Locations.Results]
}
