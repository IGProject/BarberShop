//
//  SplashScreenViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

  let network: NetworkManager = NetworkManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()

      NetworkManager.isUnreachable { _ in
        
      }
    }

  private func showOfflinePage() -> Void {
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
    }
  }
  
  private func showMainPage() -> Void {
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "MainController", sender: self)
    }
  }
  
}
