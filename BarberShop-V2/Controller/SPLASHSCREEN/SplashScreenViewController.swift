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
  
  private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
      
      NetworkManager.isUnreachable { _ in
        
      }
      
      view.backgroundColor = UIColor.white
      view.addSubview(activityIndicator)
      activityIndicator.frame = view.bounds
      activityIndicator.backgroundColor =  UIColor(white: 0, alpha: 0.4)
    }

  
  private func makeServiceCall(){
      activityIndicator.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
       self.activityIndicator.stopAnimating()
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
