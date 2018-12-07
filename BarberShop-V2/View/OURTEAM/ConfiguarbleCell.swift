//
//  ConfiguarbleCell.swift
//  BarberShop-V2
//
//  Created by User on 11/27/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
protocol ConfigurableCell {
  associatedtype DataType
  func configure(data: DataType)
}
