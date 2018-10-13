//
//  SidebarMenuViewModel.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

protocol SidebarMenuDelegate: class {
    func sidebarDidSelectRow(row: Rows)
}

enum Rows: String {
    case editProfile
    case home
    case my_appointments
    case reward_points
    case history
    case setting
    case about_us
    case signOut
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .editProfile
        case 1: self = .home
        case 2: self = .my_appointments
        case 3: self = .reward_points
        case 4: self = .history
        case 5: self = .setting
        case 6: self = .about_us
        case 7: self = .signOut
        default: self = .none
        }
    }
}




