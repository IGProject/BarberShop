//
//  LoginViewModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa


//FieldViewModel
protocol ValidationViewModel {
    var errorMessage: String {get}
    
    //Observables
    var data: Variable<String> {get set}
    var errorValue: Variable<String?> {get}
    
    //Validation
    func validateCredentials() -> Bool
}

extension ValidationViewModel {
    func validateLength(_ value: String, size: (min:Int,max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validatePattern(_ value: String?,pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}

//Security FieldView

protocol SecureFieldViewModel {
    var isSecureTextEntry: Bool {get}
}

class PasswordViewModel: ValidationViewModel,SecureFieldViewModel {
    var isSecureTextEntry: Bool = true
    
    var errorMessage: String = "Please enter a valid Password"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        guard  validateLength(data.value, size: (6,15)) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = ""
        return true
    }
}


class EmailIdViewModel: ValidationViewModel {
    var errorMessage: String = "Please enter a valid Email Id"
    
    var data: Variable<String> = Variable("")
    
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        
        guard validatePattern(data.value, pattern: emailPattern) else {
            errorValue.value = errorMessage
            return false
        }
        
        errorValue.value = ""
        return true
    }
}

class SignInViewModel {
    var model: SignInModel
    private let disposeBag = DisposeBag()
    
    let emailFieldViewModel = EmailIdViewModel()
    let passwordFieldViewModel = PasswordViewModel()
    
    //RX
    let isLoading = Variable(false)
    let isSuccess = Variable(false)
    var errorMessage = Variable<String?>(nil)
    
    init(model: SignInModel) {
        self.model = model
    }
    
    func validForm() -> Bool {
        return emailFieldViewModel.validateCredentials() && passwordFieldViewModel.validateCredentials()
    }
    
    func signIn(){
        //update model
        model.email = emailFieldViewModel.data.value
        model.password = passwordFieldViewModel.data.value
        
        //launch request
    
    }
}








