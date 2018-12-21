//
//  PostItemBookApointmentUserId.swift
//  BarberShop-V2
//
//  Created by User on 12/14/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

extension ApointmentCalendarViewController {
  
  func setupApointment(){
    let apointment = Apointment(user_id: userId!)
    let apointmentEndPoint = URL(string: Domains.BaseURL + "/bookItem/appointment")!
    let param:[String:Int] = ["user_id":apointment.user_id]
    postApointment(endpoint:apointmentEndPoint,param:param)
  }
  
  func postApointment(endpoint:URL,param:[String:Any]){
    Alamofire.request(endpoint, method: .post, parameters: param).responseJSON { response in
      switch response.result {
      case .success(_):
        let jsonData = response.data
        do{
          let apointmentResponse = try JSONDecoder().decode(ApointmentResponse.self, from: jsonData!)
           self.bookingItems  =  apointmentResponse.booking
          
        }catch let err {
          print("error:", err.localizedDescription)
        }
      case .failure(let error):
        print("failure:\(error.localizedDescription)")
      }
    }
  }
  
}
