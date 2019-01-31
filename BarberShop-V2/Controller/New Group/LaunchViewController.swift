//
//  LaunchViewController.swift
//  BarberShop-V2
//
//  Created by User on 1/26/19.
//  Copyright © 2019 minea. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
  
  let network: NetworkManager = NetworkManager.sharedInstance
  
    override func viewDidLoad() {
        super.viewDidLoad()

      NetworkManager.isUnreachable { _ in
         self.showOfflinePage()
      }
      
      NetworkManager.isReachable { _ in
        self.showMainPage()
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
