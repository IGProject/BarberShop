//
//  ContentCellViewModel.swift
//  BarberShop-V2
//
//  Created by User on 9/17/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ContentCellViewModel {
    var imageIcon: Variable<String> {get}
    var title: Variable<String> {get}
}
