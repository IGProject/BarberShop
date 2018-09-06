//
//  BarberTeamsModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
struct TeamDetails: Decodable {
    let id: Int?
    let username: String?
    let phone: String?
    let email: String?
    let description:String?
    let location:[LocationDetail]?
    let team_profile: String
    let team_image = [TeamImage]()
}

struct TeamImage: Decodable {
    let file_id:Int?
    let file_name:String?
    let file_path:String?
    let status: Bool?
}
