//
//  HomeModel.swift
//  BarberShop-V2
//
//  Created by User on 6/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
struct HomeModel{
    let name: String
    let imageName: UIImage
}

struct ProfileModel:Codable {
    let username:String
    let email:String
    let image:String
}

struct ContentModel {
    let image: String
    let contentText:String
}
