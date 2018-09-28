//
//  ProductModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct Products: Codable {
    struct Results: Codable {
        let id:Int
        let title:String
        let price: String
        let image_product: String
    }
    
    struct ProductImage: Codable {
        let id: Int?
        let file_name: String
        let file_path: String?
        let status: Bool?
    }
    let results:[Products.Results]
}
