//
//  HairStyleModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct HairStyleModel: Decodable {
    let id:Int?
    let shape:Shape?
    let style_profile:String?
    let style_profiles:[StyleProfile]?
}

struct Shape: Decodable {
    let id:Int
    let shape_name:String?
}


enum ShapeType {
    
    case Round
    case Circle
    case Square
}
struct StyleProfile: Decodable {
    let id: Int?
    let file_name: String
    let file_path: String?
    let status: Bool?
}


