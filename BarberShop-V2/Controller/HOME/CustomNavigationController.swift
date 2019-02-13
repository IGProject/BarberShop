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

protocol getBudgeNotification {
  func getValueBudge(value:Int)
}

class CustomNavigationController: UINavigationController,NotificationListener {
  
  @IBOutlet weak var teamTitleTabar: UITabBarItem!
  @IBOutlet weak var serviceTitleTabar: UITabBarItem!
  @IBOutlet weak var locationTitleTabar: UITabBarItem!
  @IBOutlet weak var bookingTitleTabar: UITabBarItem!
  @IBOutlet weak var moreTitleTabar: UITabBarItem!
  
  
  var delegates: getBudgeNotification?
  lazy var notification:UIButton = {
    let notification = UIButton()
    notification.setImage(#imageLiteral(resourceName: "notification-white-30"), for: .normal)
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
  
  let countNotificaton = UserDefaults.standard.value(forKey: "budge") as? Int ?? 0
  let changecountNotificaton = UserDefaults.standard.value(forKey: "budges") as? Int ?? 0
  

  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.tabBarController?.tabBar.items?[0].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: BarberTitleKey.teamTitleBarKey.rawValue, comment: "")
    self.tabBarController?.tabBar.items?[1].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: BarberTitleKey.serviceTitleBarKey.rawValue, comment: "")
    self.tabBarController?.tabBar.items?[2].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: BarberTitleKey.locationTitleBarKey.rawValue, comment: "")
    self.tabBarController?.tabBar.items?[3].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: BarberTitleKey.bookingTitleBarKey.rawValue, comment: "")
    self.tabBarController?.tabBar.items?[4].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: BarberTitleKey.moreTitleBarKey.rawValue, comment: "")
    
    
    if countNotificaton > 0{
      countLabel.text = " \(String(describing: countNotificaton))  "
    }else {
      countLabel.text = ""
    }
    
    print("count:\(countNotificaton)")
  }

  
  
 
  override func viewDidLoad() {
        super.viewDidLoad()
     (UIApplication.shared.delegate as! AppDelegate).mNotCallback = self
     setupNavView()
    
    }
  
  
  func onNotificationLoad(value: Int) {
    if value > 0{
      countLabel.text = String(" \(value)  ")
    }else {
      countLabel.text = ""
    }
    print("value:\(value)")
    UserDefaults.standard.set(value, forKey:"budge")
  }
  
  func setupNavView(){
  
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.backgroundColor = COlorCustom.hexStringToUIColor(hex:"#00695C")
    UIApplication.shared.statusBarView?.backgroundColor = COlorCustom.hexStringToUIColor(hex:"#00695C")
    
    countLabel.textAlignment = .center
    
    let navView = UIView()
    let imageUrl = UserDefaults.standard.object(forKey: UserKeys.userProfile.rawValue) as? String
    let imageUrlEmail = UserDefaults.standard.object(forKey: UserKeys.userProfileEmail.rawValue) as? String
    let type = UserDefaults.standard.object(forKey: UserKeys.type.rawValue) as? Int
    
    print("urlIMage:\(imageUrl ?? "")")
    print("urlIMageSocial:\(String(describing: imageUrlEmail ?? ""))")
    let url = URL(string: Domains.BaseURL)!

    let urlProfile = url.appendingPathComponent(imageUrlEmail ?? "")
    profile.kf.setImage(with: urlProfile,placeholder: #imageLiteral(resourceName: "avatar-user"))
    
    if  type != nil {
      switch type {
      case 3,4:
        let urlImage = URL(string: imageUrl ?? "")
        profile.kf.setImage(with: urlImage,placeholder: #imageLiteral(resourceName: "avatar-user"))
        print("urlIMageSocial:\(String(describing: urlImage))")
      default:
        print("urlImage")
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
    
   // countLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
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
