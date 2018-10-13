//
//  SignupViewViewModel.swift
//  BarberShop-V2
//
//  Created by User on 10/3/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//struct RegisterModel:Codable {
//    var username: String
//    var email: String
//    var phone: String
//    var password: String
//    var base64_image: String
//    var type: UserType
//}
//Validation TextField

protocol SignupViewViewModelPresentable {
    var usernameText:Variable<String> {get set}
    var emailText:Variable<String> {get set}
    var phoneText:Variable<String>{get set}
    var passwordText:Variable<String>{get set}
    var passwordConfirmText: Variable<String> {get set}
    var profileImage: Variable<String> {get set}
    
    func uploadPhoto()
    func signUp()
    func signIn()
    func reloading()
}
