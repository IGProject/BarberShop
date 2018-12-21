//
//  CustomNavigationController.swift
//  BarberShop-V2
//
//  Created by User on 12/20/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
  
  var navBar: UINavigationBar!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: view.bounds.maxY))
      navBar.setBackgroundImage(UIImage(), for: .default)
      let navItem = UINavigationItem(title: "")
      let notification = UIBarButtonItem(image: #imageLiteral(resourceName: "cm_bell_white"), style: .plain, target: self, action: #selector(notificatinAlert))
      let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(someAction))
      navItem.rightBarButtonItems = [button,notification]
      navBar.setItems([navItem], animated: false)
      
       view.addSubview(navBar)
      
    }
  
  @objc func someAction(){
    
  }
  
  @objc func notificatinAlert(){
    
  }

}
