//
//  BookingViewModel.swift
//  BarberShop-V2
//
//  Created by User on 7/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
class BookingViewModel {
    
    
//    init(withBooking booking: BookingDetail) {
//        self.booking = booking
//
//        self.user = (booking.user_id.username)
//        self.userImage = booking.user_id.image!
//        self.userId = booking.user_id.id!
//        self.locationId = booking.location_id.id!
//        self.barberId = booking.team_id.id!
//        self.serviceId = booking.seva_id.id!
//
//        self.dateTimeString = Dynamic(BookingViewModel.getDateTime(for: booking))
//        self.locationString = Dynamic(BookingViewModel.getLocation(booking))
//        self.serviceString = Dynamic(BookingViewModel.getService(booking))
//        self.barberString = Dynamic(BookingViewModel.getBarber(booking))
//    }
//
//
//
//    //MARK: DateTime
//    fileprivate static func dateTimeFormatted(dateTime: String) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
//        let calculateDateTime = formatter.string(from: Date())
//        return calculateDateTime
//    }
//
//    fileprivate static func getDateTime(for booking: BookingDetail) -> String {
//        return dateTimeFormatted(dateTime: "\(booking.work_time)")
//    }
//
//    func valueDateChange(){
//
//    }
//
//    //MARK: Location
//    fileprivate static func getLocation(_ location: BookingDetail) -> String {
//        return location.location_id.address!
//    }
//
//    //MARK: Service
//    fileprivate static func getService(_ service: BookingDetail) -> String {
//        return service.seva_id.title!
//    }
//
//    //MARK: Barber
//    fileprivate static func getBarber(_ barber: BookingDetail) -> String {
//        return barber.team_id.username!
//    }
}
