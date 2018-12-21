//
//  Alert.swift
//  BarberShop-V2
//
//  Created by User on 12/15/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

struct AlertController {
  static func showBasicAlert(on vc:UIViewController,with title:String,message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
    DispatchQueue.main.async {
      vc.present(alert, animated: true)
    }
  }
  
  static func showAlertWhenTextEmpty(on vc:UIViewController,with title:String,message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    DispatchQueue.main.async {
      vc.present(alert, animated: true)
    }
  }
  
  static func cancelBookingFormAlert(on vc:UIViewController){
    showBasicAlert(on: vc, with: "Choose", message: "You you want to Cancel?")
  }
  
  static func pleaseWriteReson(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Empty Text", message: "Please write your reason")
  }
}
