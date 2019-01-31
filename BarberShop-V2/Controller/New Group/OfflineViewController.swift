//
//  OfflineViewController.swift
//  BarberShop-V2
//
//  Created by User on 11/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class OfflineViewController: UIViewController {

  let network = NetworkManager.sharedInstance
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      network.reachability.whenReachable = { reachability in
        self.showMainController()
      }
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
     // network.reachability.allowsCellularConnection = true
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  private func showMainController() -> Void {
    DispatchQueue.main.async {
      self.performSegue(withIdentifier: "MainController", sender: self)
    }
  }
}
