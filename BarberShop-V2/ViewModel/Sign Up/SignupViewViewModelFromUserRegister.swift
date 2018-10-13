//
//  SignupViewViewModelFromUserRegister.swift
//  BarberShop-V2
//
//  Created by User on 10/3/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
struct SignupViewViewModelFromUserRegister {
  
    //Model
    fileprivate var userRegister: RegisterModel
    //Service
   // fileprivate let service: AppServerClient!
    //TextField
    var usernameText: Variable<String> = Variable("")
    var emailText: Variable<String> = Variable("")
    var phoneText: Variable<String> = Variable("")
    var passwordText: Variable<String> = Variable("")
    var passwordConfirmText: Variable<String> = Variable("")
    var profileImage: Variable<String> = Variable("")
    
    
    
    func uploadPhoto() {
        
    }
    
    func signUp() {
        
    }
    
    func reloading() {
        
    }
    
    func signIn() {
        
    }
    
    //MARK:Init
    init(withUser user:RegisterModel) {
        self.userRegister = user
        self.usernameText.value = user.username
        self.phoneText.value = user.phone
        self.passwordText.value = user.password
        self.profileImage.value = user.base64_image!
   }
//
}

