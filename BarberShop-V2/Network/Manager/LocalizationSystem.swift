//
//  LocalizationSystem.swift
//  BarberShop-V2
//
//  Created by User on 1/3/19.
//  Copyright © 2019 minea. All rights reserved.
//

import Foundation
import UIKit

class LocalizationSystem: NSObject {
  var bundle: Bundle!
  
  class var sharedInstance: LocalizationSystem {
    struct Singleton {
      static let instance:LocalizationSystem = LocalizationSystem()
    }
    return Singleton.instance
  }
  
  override init() {
    super.init()
    bundle = Bundle.main
  }
  
  func localizedStringForKey(key:String,comment:String) -> String {
    return bundle.localizedString(forKey: key, value: comment, table: nil)
  }
  
  func localizedImagePathForImg(imagename:String,type:String) -> String {
    guard let imagePath = bundle.path(forResource: imagename, ofType: type) else {
      return ""
    }
    return imagePath
  }
  
  //MARK:- setLanguage
  func setLanguage(languageCode:String){
    var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
    appleLanguages.remove(at: 0)
    appleLanguages.insert(languageCode, at: 0)
    UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
    UserDefaults.standard.synchronize() //needs restart
    
    if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
       bundle = Bundle.init(path: languageDirectoryPath)
    }else {
      resetLocalization()
    }
  }
  
  //MARK:- resetLocalization
  
  func resetLocalization(){
    bundle = Bundle.main
  }
  
  //MARK:- getLanguage
  //Just get the current setted up language
  func getLanguage() -> String {
    let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
    let prefferedLanguage = appleLanguages[0]
    if prefferedLanguage.contains("-") {
      let array = prefferedLanguage.components(separatedBy: "-")
      return array[0]
    }
    return prefferedLanguage
  }
}
