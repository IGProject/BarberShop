//
//  RegistrationViewModel.swift
//  BarberShop-V2
//
//  Created by User on 10/1/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct RegistrationButtonViewModel {
    //Model
    var signupModel: RegisterModel
    private let disposeBag = DisposeBag()
    private let appServerClient: AppServerClient

    let usernameFieldViewModel = UsernameTextFieldViewModel()
    let phoneFieldViewModel = PhoneTextFieldViewModel()
    let emailFieldViewModel = EmailTextFieldViewModel()
    let passwordFieldViewModel = PasswordTextFieldViewModel()
    let passwordConfirmFieldViewModel = PasswordConfirmTextFieldViewModel()

    init(model: RegisterModel,appServerClient: AppServerClient){
        self.signupModel = model
        self.appServerClient = appServerClient
    }



    func validForm() -> Bool {
        return usernameFieldViewModel.validateCredentials() && phoneFieldViewModel.validateCredentials() && emailFieldViewModel.validateCredentials() && passwordFieldViewModel.validateCredentials() && passwordConfirmFieldViewModel.validateCredentials()
    }

    mutating func signup(){
        //update model
        signupModel.username = usernameFieldViewModel.data.value
        signupModel.phone = phoneFieldViewModel.data.value
        signupModel.email = emailFieldViewModel.data.value
        signupModel.password = passwordFieldViewModel.data.value

        //launch request
        appServerClient.postRegister(username: signupModel.username, phone: signupModel.phone, password: signupModel.password, type: signupModel.type.rawValue) { result in
            switch result {
            case .success:
            print("success")
            case .failure(let error):
                print(error?.localizedDescription ?? "")
            }
        }

    }

}
