//
//  ProductModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct ProductDetails: Codable {
    let id:Int
    let title:String?
    let price:String?
    let image_product: ProductImage?
}

struct ProductImage: Codable {
    let id: Int
    let file_name: String?
    let file_path: String?
    let status: Bool?

}
