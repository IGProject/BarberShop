//
//  BarberTeamsModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct Teams: Codable {
    struct Results: Codable {
        let id: Int
        let username: String
        let email: String
        let description: String
        let location: Location
        let team_profile: String
        let team_image: [TeamImage]
    }
    struct Location: Codable {
        let id: Int
        let address: String
        let latitude: String
        let longitude: String
    }
    
    struct TeamImage: Codable {
        let id:Int
        let file_name: String
        let file_path: String
        let status: Bool
    }
    
    let results: [Teams.Results]
}
