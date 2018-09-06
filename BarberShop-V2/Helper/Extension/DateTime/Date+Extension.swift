//
//  Date+Extension.swift
//  BarberShop-V2
//
//  Created by User on 7/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
extension Date {
    static func calculateDate(day:Int,month:Int,year:Int,hour:Int,minute:Int) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mmm/yyyy HH:mm"
        let calculateDate = formatter.date(from: "\(day)/\(month)/\(year) \(hour):\(minute)")
        return calculateDate!
    }
    
    func getDateTime() -> (day:Int,month:Int,year:Int,hour:Int,minute:Int){
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        
        return(day,month,year,hour,minute)
    }
}
