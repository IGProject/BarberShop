//
//  SignUpViewModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import RxSwift
import RxSwift
import RxCocoa

//Validate Field
protocol ValidationFieldRegisterViewModel {
    var errorMessage: String {get}
    //Observables
    var data: Variable<String> {get set}
    var errorValue: Variable<String?> {get}
    
    //Validation
    func validateCredentials() -> Bool
}

extension ValidationFieldRegisterViewModel {
    func validateLength(_ value: String, size: (min:Int,max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validatePattern(_ value: String?,pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}

//Security FieldView

protocol SecureTextFieldViewModel {
    var isSecureTextEntry: Bool {get}
}
////////////////////////////////////

struct UsernameTextFieldViewModel: ValidationFieldRegisterViewModel {
    var errorMessage: String = "Please enter a username"
    
    var data: Variable<String> = Variable("")
    
    var errorValue: Variable<String?> = Variable(nil)
    
    func validateCredentials() -> Bool {
        let usernamePattern = "^[0-9a-zA-Z\\_]{7,18}$"
        guard validatePattern(data.value, pattern: usernamePattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}

struct PhoneTextFieldViewModel:ValidationFieldRegisterViewModel {
    var errorMessage: String = "Please enter a phone"
    
    var data: Variable<String> = Variable("")
    
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        let phonePattern = "^\\d{3}-\\d{3}-\\d{4}$"
        guard validatePattern(data.value, pattern: phonePattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}

struct emailTextFieldViewModel: ValidationFieldRegisterViewModel {
    var errorMessage: String = "Please enter a email"
    
    var data: Variable<String> = Variable("")
    
    var errorValue: Variable<String?> = Variable(nil)
    
    func validateCredentials() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        guard validatePattern(data.value, pattern: emailPattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}

//PasswordTextField
struct PasswordTextFieldViewModel: ValidationFieldRegisterViewModel,SecureTextFieldViewModel {
    var isSecureTextEntry: Bool = true
    
    var errorMessage: String = "Please enter a valid Password"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        guard  validateLength(data.value, size: (6,15)) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}

//Password confirm
struct PasswordConfirmTextFieldViewModel: ValidationFieldRegisterViewModel,SecureTextFieldViewModel {
    var isSecureTextEntry: Bool = true
    
    var errorMessage: String = "Please enter a valid Password"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    func validateCredentials() -> Bool {
        guard  validateLength(data.value, size: (6,15)) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}







