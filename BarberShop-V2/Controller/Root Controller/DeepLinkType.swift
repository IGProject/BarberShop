//
//  DeepLinkType.swift
//  BarberShop-V2
//
//  Created by User on 12/18/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit

enum DeeplinkType {
  case messages
  case activity
}

let Deeplinker = DeepLinkManager()

class DeepLinkManager {
  fileprivate init(){}
  
  private var deeplinkType:DeeplinkType?
  
  @discardableResult
  func handleShortcut(item: UIApplicationShortcutItem) -> Bool {
    deeplinkType = ShortcutParser.shared.handleShortcut(item)
     return deeplinkType != nil
  }
  // check existing deepling and perform action
  func checkDeepLink(){
//      AppDelegate.shared.rootViewController.deeplink = deeplinkType
    //reset deeplink after handling
   // self.deeplinkType = nil
  }
}
