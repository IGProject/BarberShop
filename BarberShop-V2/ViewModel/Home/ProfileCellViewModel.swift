//
//  ProfileCellViewModel.swift
//  BarberShop-V2
//
//  Created by User on 9/17/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProfileCellViewModel {
    var profileImage: Variable<String> {get}
    var usernmae: Variable<String> {get}
    var email: Variable <String> {get}
}

