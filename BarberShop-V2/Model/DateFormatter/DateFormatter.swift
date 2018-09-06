//
//  DateFormatter.swift
//  BarberShop-V2
//
//  Created by User on 6/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
extension DateFormatter {
    static var articleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }
}
