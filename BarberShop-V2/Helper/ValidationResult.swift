//
//  ValidationResult.swift
//  BarberShop-V2
//
//  Created by User on 9/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

enum SignUpState {
    case signedUp(signedUp: Bool)
}

protocol SignUpAPI {
    func usernameAvailable(_ username: String) -> Observable<Bool>
    func signup(_ username:String,password: String) -> Observable<Bool>
}

protocol SignUpValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
           return true
        default:
            return false
        }
    }
}
