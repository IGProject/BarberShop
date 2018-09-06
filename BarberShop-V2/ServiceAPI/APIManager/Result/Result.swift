//
//  Result.swift
//  BarberShop-V2
//
//  Created by User on 6/14/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
public enum Result<Model,E> where E:Error {
    case success(Model)
    case failure(E)
}
