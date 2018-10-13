//
//  AddUserBooking.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol AddUserBookingViewModel {
    var dateTime: Variable<Date> {set get}
    var location: Variable<String> {set get}
    var service: Variable<String> {set get}
    var team: Variable<String> {set get}
    var showLoadingHud: Observable<Bool> {get}
}

