//
//  HairStyleModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct StyleHair: Codable {
  var length: Int
    struct Results:Codable {
        let id:Int
        let shape: Shape
        let style_profile: String
        let style_profiles: [StyleProfile]
    }
    struct Shape: Codable {
        let id: Int
        let shape_name: String
    }
    struct StyleProfile: Codable {
        let id: Int?
        let file_name: String
        let file_path: String
        let status: Bool
    }
    var results:[StyleHair.Results]
}


