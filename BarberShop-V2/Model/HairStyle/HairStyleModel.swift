//
//  HairStyleModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct StyleListModel: Codable {
    let id:Int
    let shape:Shape
    let style_profile:String
    let style_profiles:[StyleProfile]
}

struct Shape: Codable {
    let id:Int
    let shape_name:ShapeType
}


enum ShapeType: String,Codable {
    
    case circleStyle
    case squareStyle
    case oblongStyle
    case diamondStyle
    case traingleStyle
    case ovalStyle
}
struct StyleProfile: Codable {
    let id: Int?
    let file_name: String
    let file_path: String?
    let status: Bool?
}


