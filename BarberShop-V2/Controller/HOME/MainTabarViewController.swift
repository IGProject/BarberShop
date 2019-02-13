//
//  CustomTabarViewController.swift
//  BarberShop-V2
//
//  Created by User on 11/16/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class MainTabarViewController: UITabBarController{
  
   let network = NetworkManager.sharedInstance
  

  override func viewDidLoad() {
        super.viewDidLoad()
      
        network.reachability.whenUnreachable = { reachability in
          self.showOfflinePage()
        }
    
   
    
    }
  

  private func showOfflinePage() -> Void {
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
    }
  }
}
