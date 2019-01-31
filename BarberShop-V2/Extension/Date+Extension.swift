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
  
  
  var millisecondsSince1970:Int {
    return Int((self.timeIntervalSince1970 * 60 * 60 * 24 * 1000).rounded())
  }
  
  init(milliseconds:Int) {
    self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / (60 * 60 * 24 * 1000))
  }
  
    func year() -> Int
    {
        //Get Hour
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        let year = components.year
        
        //Return Hour
        return year!
    }
    
    func month() -> Int
    {
        //Get Hour
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        let month = components.month
        
        //Return Hour
        return month!
    }
    
    func day() -> Int
    {
        //Get Hour
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        let day = components.day
        
        //Return Hour
        return day!
    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self)
        let hour = components.hour
        
        //Return Hour
        return hour!
    }
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: self)
        let minute = components.minute
        
        //Return Minute
        return minute!
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: self)
        
        //Return Short Time String
        return timeString
    }
    
    func toHourMinuteString() -> String {
        var hourMinute: String
        if self.minute() == 0 {
            hourMinute = "\(self.hour()):\(self.minute())" + "0"
        } else {
            hourMinute = "\(self.hour()):\(self.minute())"
        }
        return hourMinute
    }
}
