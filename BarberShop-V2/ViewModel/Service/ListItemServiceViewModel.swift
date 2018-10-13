//
//  ListItemServiceViewModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol ListItemServiceViewModel {
    var title: Variable<String> {get}
    var price: Variable<String> {get}
    var desc: Variable<String> {get}
    func booking()
}
