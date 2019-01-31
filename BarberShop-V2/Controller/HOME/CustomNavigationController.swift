//
//  CustomNavigationController.swift
//  BarberShop-V2
//
//  Created by User on 12/20/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class CustomNavigationController: UINavigationController {
  
  lazy var notification:UIButton = {
    let notification = UIButton()
    notification.setImage(#imageLiteral(resourceName: "notification-30"), for: .normal)
    notification.isUserInteractionEnabled = true
    notification.addTarget(self, action: #selector(self.notificationAlert), for: .touchUpInside)
    notification.translatesAutoresizingMaskIntoConstraints = false
    return notification
  }()
  
  lazy var countLabel:UILabel = {
   
    let countLabel = UILabel()
    countLabel.backgroundColor = .red
    countLabel.isUserInteractionEnabled = true
    countLabel.layer.masksToBounds = false
    countLabel.layer.cornerRadius = 8
    countLabel.font = UIFont.boldSystemFont(ofSize: 13)
    countLabel.adjustsFontSizeToFitWidth = true
    countLabel.minimumScaleFactor = 0.3
    countLabel.clipsToBounds = true
    countLabel.textColor = .white
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    return countLabel
  }()
  
  lazy var profile:UIImageView = {
    let profile = UIImageView()
  profile.contentMode = .scaleAspectFill
  profile.layer.masksToBounds = true
  profile.layer.cornerRadius = 15.0
  profile.clipsToBounds = true
  profile.translatesAutoresizingMaskIntoConstraints = false
    return profile
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    var countNotificaton = UserDefaults.standard.value(forKey: NotificationAlert.countNotification.rawValue) as? Int {
      didSet{
        countLabel.text = "\(String(describing: countNotificaton ?? 0))"
      }
    }
    
   countLabel.text = "\(String(describing: countNotificaton ?? 0))"
  }
  override func viewDidLoad() {
        super.viewDidLoad()

     setupNavView()
   
    }
  
  
  func setupNavView(){
  
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
   navigationBar.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 0/255, green: 105/255, blue: 92/255, alpha: 1.0)
    
    countLabel.textAlignment = .center
    
    let navView = UIView()
    let imageUrl = UserDefaults.standard.object(forKey: UserKeys.userProfile.rawValue) as? String
    let type = UserDefaults.standard.object(forKey: UserKeys.type.rawValue) as? Int
    
    
     let urlImage = URL(string: imageUrl!)!
    let url = URL(string: Domains.BaseURL)!
    
    if  type != nil {
      switch type {
      case 3,4:
        profile.kf.setImage(with: urlImage)
      default:
        let urlProfile = url.appendingPathComponent(imageUrl!)
        profile.kf.setImage(with: urlProfile)
      }
    }
    

    navView.addSubview(profile)
    navView.addSubview(notification)
    notification.addSubview(countLabel)
    
    notification.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
    notification.leftAnchor.constraint(equalTo: navView.leftAnchor, constant: 10).isActive = true
    notification.rightAnchor.constraint(equalTo: navView.rightAnchor, constant: -60).isActive = true
    notification.widthAnchor.constraint(equalToConstant: 25).isActive = true
    notification.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    countLabel.topAnchor.constraint(equalTo: navView.topAnchor.self, constant: -4).isActive = true
    countLabel.leftAnchor.constraint(equalTo: notification.rightAnchor.self, constant: -15).isActive = true
    
  //  countLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
    //countLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    
    profile.topAnchor.constraint(equalTo: navView.topAnchor).isActive = true
    profile.leftAnchor.constraint(equalTo: notification.rightAnchor, constant: 20).isActive = true
    profile.rightAnchor.constraint(equalTo: navView.rightAnchor, constant: -10).isActive = true
    profile.centerYAnchor.constraint(equalTo: navView.centerYAnchor).isActive = true
    profile.widthAnchor.constraint(equalToConstant: 30).isActive = true
    profile.heightAnchor.constraint(equalToConstant: 30).isActive = true

    
    let rightBarButton = UIBarButtonItem(customView: navView)
    
   navigationItem.rightBarButtonItem = rightBarButton
   navigationBar.setItems([navigationItem], animated: false)
  
  }
  

  @objc func notificationAlert(){
    let storyboard:UIStoryboard = UIStoryboard(storyboard: .History)
    let history = storyboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
    self.present(history, animated: true)
  }
  
}
