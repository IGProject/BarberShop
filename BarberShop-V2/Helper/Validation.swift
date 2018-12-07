//
//  Validation.swift
//  BarberShop-V2
//
//  Created by User on 11/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

enum Alert {
  case success
  case failure
  case error
}

enum Valid {
  case success
  case failure(Alert,AlertMessages)
}

enum AlertMessages: String {
  case inValidEmail = "InvalidEmail"
  case invalidFirstLetterCaps = "First Letter should be capital"
  case invalidUsername = "username should more than 6"
  case inValidPhone  = "Invalid Phone"
  case invalidAlphabeticString = "Invalid String"
  case inValidPSW = "Invalid Password"
  
  case emptyUsername = "should enter username"
  case emptyPhone = "Empty Phone"
  case emptyEmail = "Empty Email"
  case emptyFirstLetterCaps = "Empty Name"
  case emptyAlphabeticString = "Empty Username"
  case emptyPSW = "Empty Password"
  
  func localized() -> String {
    return NSLocalizedString(self.rawValue, comment: "")
  }
}

enum ValidationType {
  case email
  case username
  case stringWithFirstLetterCap
  case phoneNo
  case alphabeticString
  case password
}

enum RegEx: String {
  case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" // Email
  case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}" //Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
  case username = "\\A\\w{6,20}\\z" //username
  case alphabeticStringWithSpace = "^[a-zA-Z ]*$" // e.g. hello sandeep
  case alphabeticStringFirstLetterCaps = "^[A-Z]+[a-zA-Z]*$" // SandsHell
  case phoneNo = "[0-9]{6,9}" // PhoneNo 10-14 Digits
  
  //Change RegEx according to your Requirement
}

class Validation: NSObject {
  public static let shared = Validation()
  
  func validate(values: (type: ValidationType,inputValue: String)...) -> Valid {
    for valueToBeChecked in values {
      switch valueToBeChecked.type {
        
      case .email:
        if let tempValue = isValidString((valueToBeChecked.inputValue,.email,.emptyEmail,.inValidEmail)){
          return tempValue
        }
      case .stringWithFirstLetterCap:
        if let tempValue = isValidString((valueToBeChecked.inputValue,.alphabeticStringFirstLetterCaps,.emptyFirstLetterCaps,.invalidFirstLetterCaps)) {
          return tempValue
        }
        
      case .phoneNo:
        if let tempValue = isValidString((valueToBeChecked.inputValue,.phoneNo,.emptyPhone,.inValidPhone)) {
          return tempValue
        }
      case .alphabeticString:
        if let tempValue = isValidString((valueToBeChecked.inputValue,.alphabeticStringWithSpace,.emptyAlphabeticString,.invalidAlphabeticString)){
          return tempValue
        }
        break
      case .password:
        if let tempValue = isValidString((valueToBeChecked.inputValue,.password,.emptyPSW,.inValidPSW)){
          return tempValue
        }
        break
      case .username:
        if let tempValue = isValidString((valueToBeChecked.inputValue,.username,.invalidUsername,.emptyUsername)){
          return tempValue
        }
      }
    }
     return  .success
  }
  
  func isValidString(_ input:(text:String,regex: RegEx,emptyAlert:AlertMessages,invalidAlert: AlertMessages)) -> Valid? {
    if input.text.isEmpty {
      return .failure(.error,input.emptyAlert)
    }else if isValidRegEx(input.text, input.regex) != true {
      return .failure(.error,input.invalidAlert)
    }
    return nil
  }
  
  func isValidRegEx(_ testStr: String,_ regex:RegEx) -> Bool {
    let stringTest = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
    let result = stringTest.evaluate(with: testStr)
    
    return result
    
  }
}
