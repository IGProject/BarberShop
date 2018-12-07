//
//  BookingPickerDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/28/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class BookingPickerDataSource: NSObject,UIPickerViewDataSource {
  
  var current_arr: [String] = []
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return current_arr.count
  }
  
  
}
