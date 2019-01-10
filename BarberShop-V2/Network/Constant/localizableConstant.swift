//
//  localizableConstant.swift
//  BarberShop-V2
//
//  Created by User on 12/28/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

enum Language: String {
  case english = "en"
  case chinese = "km"
}

enum SignIn:String {
  case emailTF = "EmailSignInKey"
  case passwordTF = "PasswordSignInKey"
  case signInBtn = "SignInBtnKey"
  case haveOrNotLb = "Don'thaveKey"
  case registerBtn  = "RegisterBtnKey"
}

enum SignUps:String {
 case signUpLb = "SignUpLabelKey"
 case usenameTF =  "UserNameSignUpKey"
 case phonenumTF = "PhoneNumberSignUpKey"
 case emailTF =  "EmailSignUpKey"
 case passwordTF =  "PsdSignUpKey"
 case confPswTF = "ConPsdSignUpKey"
 case signUpBtn = "SignUpBtnKey"
 case doyouhaveLb = "DoyouhaveKey"
 case signInBtn = "SignInbtnKey"
}

enum OurTeam:String {
  case tabarTeamTitle = "tabarTeamTitleKey"
  case userNameLb = "userNameTeamKey"
  case phoneNumLb = "phonenumTeamKey"
  case bookBtnTeam = "bookingBtnTeamKey"
}

enum OurTeamDetail:String {
  case navigaTeamDetail = "navgatTeamDetailKey"
  case usernameLb = "userNameTeamDetailKey"
  case phoneNumLb = "phonenumTeamDetailKey"
  case emailLb = "emailTeamDetailKey"
  case descriptLb = "descriptionTeamDetailKey"
  case bookingBtn = "bookingBtnTeamDetailKey"
}

enum ServiceBarber:String {
 case tabarServiceTitle = "tabarServiceTitleKey"
 case serviceLb = "serviceServKey"
 case pricesLb = "pricesServKey"
 case dollarLb = "dollarServKey"
 case descriptLb = "descriptionServKey"
 case bookingBtn = "bookingBtnKey"
}

enum ServiceDetail:String {
  case titleLb = "titleServDetailKey"
  case pricesLb = "priceServDetailKey"
  case pointLb = "pointServDetailKey"
  case descriptLb = "descriptionServDetailKey"
  case bookingBtn = "bookingBtnServDetailKey"
}

enum byLocation:String {
 case byLocation = "byLocationKey"
 case nearest = "nearestKey"
  case tabarLocationTitle = "tabarLocationTitleKey"
  case nameLb = "nameByLocatKey"
  case addressLb = "addressByLocatKey"
  case phoneLb = "phoneByLocatKey"
  case timeLb = "timeByLocatKey"
  case bookingBtn = "bookingBtnKey"
}

enum BookingBarber:String {
 case tabarLocationTitle = "tabarLocationTitleKey"
 case dateTimeTF = "dateTimeBookingKey"
 case locationTF = "locationBookingKey"
 case serviceTF = "servicesBookingKey"
 case teamTF = "teamBookingKey"
 case confirmBtnBooking = "confirmBtnBookingKey"
 case updateBtn = "updatebtnBookingKey"
}

enum ApointmentBarber:String {
 case statusLb = "statusApointmentKey"
 case teamLb = "teamApointmentKey"
  case timeLb = "timeApointmentKey"
}

enum ApointmentDetail:String {
  case userNameLb = "userNameApointDetailKey"
  case dateLb = "dateApointDetailKey"
  case location = "locationApointDetailKey"
  case status = "statusApointDetailKey"
}


enum MoreTable:String {
 case tabarMoreTitle = "tabarMoreTitleKey"
 case apointmentLb = "apointmentLbKey"
 case awardpointLb = "awardpointLbKey"
 case historyLb = "historyLbKey"
 case hairstyleLb = "hairstyleLbKey"
 case productLb = "productLbKey"
 case settingLb = "settingLbKey"
 case aboutUsLb = "aboutUsLbKey"
 case logoutLb = "logoutLbKey"
}


enum SettingTable:String {
case apointmentTitle = "apointmentTitleLbKey"
case remainderTitleLb = "remainderTitleLbKey"
case beforeLb = "beforeLbKey"
case laterLb = "laterLbKey"
case navTitle = "navTitleKey"
case saveItemTitle = "saveItemTitleKey"
}