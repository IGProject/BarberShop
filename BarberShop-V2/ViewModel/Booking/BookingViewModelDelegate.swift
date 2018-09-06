//
//  DateTimeViewModel.swift
//  BarberShop-V2
//
//  Created by User on 7/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit

protocol BookingViewModelDelegate {
    var user:String {get}
    var userImage: String {get}
    
    var userId: Int {get}
    var locationId: Int {get}
    var barberId: Int {get}
    var serviceId: Int {get}
//    var dateTimeString: Dynamic<String> {get}
//    var locationString: Dynamic<String> {get}
//    var serviceString: Dynamic<String> {get}
//    var barberString: Dynamic<String> {get}
    
    func bookingConfirm()
}

