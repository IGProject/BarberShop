//
//  Result.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

enum EmptyResult<U: Error> {
    case success
    case failure(U?)
}
