//
//  Apointment.swift
//  BarberShop-V2
//
//  Created by User on 12/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

struct Apointment: Codable {
  let user_id:Int
  
  init(user_id:Int) {
    self.user_id = user_id
  }
}
