//
//  ServiceModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct ServicesDetails: Codable{
    //filed of Service
    let id:Int?
    let title:String?
    let description:String?
    let price:String?
    let point:Int?
    let seva_profile:String?
    let seva_profiles: ServiceProfiles?
}

//subclass name Service Profile of Service
struct ServiceProfiles: Codable{
    let file_id:String?
    let file_name:String
    let file_path:String?
    let status:Bool?
}


