//
//  HairstyleCollectionViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
protocol StyleHairBookingCellDelegate {
  func didTapTeamBooking(_ T: HairstyleCollectionCell,_ data:StyleHair.Results)
}

class HairstyleCollectionCell: UICollectionViewCell,ConfigurableCell {
    
    @IBOutlet weak var imageStyleHair: UIImageView!
    @IBOutlet weak var shapeNameLabel: UILabel!
  
  var dataStyleHair:StyleHair.Results? = nil
  let url = URL(string: Domains.BaseURL)!
  
  func configure(data styleHair: StyleHair.Results) {
    let urlImage = url.appendingPathComponent(styleHair.style_profile)
    self.imageStyleHair.kf.setImage(with: urlImage)
    self.shapeNameLabel.text = styleHair.shape.shape_name
    self.dataStyleHair = styleHair
  }
}
