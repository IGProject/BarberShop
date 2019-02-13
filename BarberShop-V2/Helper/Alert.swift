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
  
  //MARK: - Alert Booking
  
  static func dateTimeEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Date Time Empty", message: "please select Date Time")
  }
  
  static func locationEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Location Empty", message: "please select Location")
  }
  
  static func serviceEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Service Empty", message: "please select Service")
  }
  
  static func teamBarberEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Team BarberShop Empty", message: "please select Team Barbershop")
  }
  
  
  //MARK: -Alert SignUp
  
  static func usernameEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Username Empty", message: "please enter username")
  }
  
  static func phoneNumEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "phone number Empty", message: "please enter phone number")
  }
  
  static func emailEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "email Empty", message: "please enter email")
  }
  
  static func passwordEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "password Empty", message: "please enter password")
  }
  
  static func repasswordEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Confirm password Empty", message: "please enter Password")
  }
  
  static func notMatchEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "Not Match", message: "password and confirm password not match")
  }
  static func imageUploadEmpty(on vc:UIViewController){
    showAlertWhenTextEmpty(on: vc, with: "image Empty", message: "please upload")
  }
  
  
}
