//
//  ServiceModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct Services: Codable {
    struct Results: Codable {
        let id: Int
        let title: String
        let description: String
        let price: String
        let point: Int
        let seva_profile: String
        let seva_profiles: [ServiceProfile]
    }
    
    struct ServiceProfile: Codable {
        struct Results:Codable {
            let id:Int?
            let file_name: String
            let file_path:String?
            let status: Bool
        }
    }
    
    let results: [Services.Results]
}
