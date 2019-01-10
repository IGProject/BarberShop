//
//  CustomTabarViewController.swift
//  BarberShop-V2
//
//  Created by User on 11/16/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class MainTabarViewController: UITabBarController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupTabar()
    }

  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    self.title = item.title
  }
  
  func setupTabar(){
    
  }
 
}
