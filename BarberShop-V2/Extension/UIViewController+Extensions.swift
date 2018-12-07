//
//  UIViewController+Extensions.swift
//  BarberShop-V2
//
//  Created by User on 11/14/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
extension UIViewController {
  func presentError(_ error: Error) {
    let alertController = UIAlertController(title: "Error",
                                            message: error.localizedDescription,
                                            preferredStyle: .alert)
    alertController.addAction(.init(title: "OK", style: .default))
    self.present(alertController, animated: true)
  }
  func presentMessage(_ message: String) {
    let alertController = UIAlertController(title: "Message",
                                            message: message,
                                            preferredStyle: .alert)
    alertController.addAction(.init(title: "OK", style: .default))
    self.present(alertController, animated: true)
  }
}
