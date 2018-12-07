//
//  ProductCollectionViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
class ProductCollectionCell: UICollectionViewCell,ConfigurableCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rielLabel: UILabel!
  
    let url = URL(string: Domains.BaseURL)!
  
  func configure(data product:Products.Results) {
    let urlImage = url.appendingPathComponent(product.image_product)
    self.imageProduct.kf.setImage(with: urlImage)
    self.titleLabel.text = product.title
    self.rielLabel.text = product.price
  }
    
}
