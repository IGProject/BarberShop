//
//  EmailProvider.swift
//  BarberShop-V2
//
//  Created by User on 6/26/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

//FvardViewModel
protocol VSFieldViewModel {
    var title: String {get}
    var errorMessage: String {get}
    
    //Observer
    var value: Variable<String> {get}
    var errorValue: Variable<String?>{get}
    
    //validation
    func validate() -> Bool
}

extension VSFieldViewModel {
    func validateSize(_ value: String, size:(min:Int,max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateString(_ value:String?,pattern: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", pattern)
        return test.evaluate(with: test)
    }
}

// Options for FieldViewModel
protocol VSSecureFieldViewModel {
    var isSecureTextEntry: Bool { get }
}


// Data FieldViewModel : Email
struct VSEmailViewModel: VSFieldViewModel {
    var title: String = "Email"
    var errorMessage: String = "Email is wrong "
    var value: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    func validate() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        guard validateString(value.value, pattern: emailPattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
    
    
}

//// Data FieldViewModel : Password
struct VSPasswordViewModel: VSFieldViewModel {
    var title: String = "Password"
    var errorMessage: String = "Wrong Password"
    var value: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    func validate() -> Bool {
        // between 8 and 25 caracters
        guard validateSize(value.value, size: (min: 8, max: 25)) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}


//class VSSigninViewModel: Provider {
//    var providerType: LoginProviderType = .Email
//    var delegate: LoginProviderDelegate?
//    
//    var model: SigninModel
//    private let disposeBag = DisposeBag()
//    let emailFieldViewModel = VSEmailViewModel()
//    let passwordFieldViewModel = VSPasswordViewModel()
//    
//    //Rx
//    let isLoading = Variable(false)
//    var isSuccess = Variable(false)
//    var errorMessage = Variable<String?>(nil)
//    
//    init(model: SigninModel) {
//        self.model = model
//    }
//    
//    func validForm() -> Bool {
//        return emailFieldViewModel.validate() && passwordFieldViewModel.validate()
//    }
//    
//    func login() {
//        
//    }
//}





