//
//  CustomNavigationController.swift
//  BarberShop-V2
//
//  Created by User on 12/20/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher

class CustomNavigationController: UINavigationController {
  
  var navBar: UINavigationBar!
  var imageProfile:UIImageView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
      self.edgesForExtendedLayout = []//Optional our as per your view ladder

      let navBar = UINavigationBar()
      navBar.setBackgroundImage(UIImage(), for: .default)
      self.view.addSubview(navBar)
  

      navBar.translatesAutoresizingMaskIntoConstraints = false
      if #available(iOS 11.0, *) {
        let guide = self.view.safeAreaLayoutGuide
        navBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant:-50).isActive = true
        navBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 0).isActive = true
      } else {
        NSLayoutConstraint(item: navBar,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view, attribute: .top,
                           multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: navBar,
                           attribute: .leading,
                           relatedBy: .equal, toItem: view,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: navBar, attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true

        navBar.heightAnchor.constraint(equalToConstant: 0).isActive = true
      }

      let navItem = UINavigationItem(title: "")

      let search = UIBarButtonItem(image: UIImage(named: "search-30")!, style: .plain, target: self, action: #selector(searchAction))
      //
      let alert = UIBarButtonItem(image: UIImage(named: "notification-30")!, style: .plain, target: self, action: #selector(alertAction))

      navItem.rightBarButtonItems = [alert]

      navBar.setItems([navItem], animated: false)
    
    setupTabarView()
    }
  
  
  @objc func someAction(){
    print("hello")
    
  }
  
  @objc func searchAction(){
    
  }
  
  @objc func alertAction(){
    
  }
  
  func setupTabarView(){
    //self.tabarTeamTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: OurTeam.tabarTeamTitle.rawValue, comment: "")
    
   // tabarServiceTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: ServiceBarber.tabarServiceTitle.rawValue, comment: "")
    
  //  tabarlocationTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.tabarLocationTitle.rawValue, comment: "")
    
   // tabarBookingTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: BookingBarber.tabarLocationTitle.rawValue, comment: "")
    
   // tabarMoreTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.tabarMoreTitle.rawValue, comment: "")
    
  }

}
