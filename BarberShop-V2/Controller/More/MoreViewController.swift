//
//  MoreViewController.swift
//  BarberShop-V2
//
//  Created by User on 2/13/19.
//  Copyright © 2019 minea. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

  @IBOutlet weak var moreTableView: UITableView!
  
  
  var moreList = [String]()
  var moreImageList = [UIImage]()
  
  let userDefault = UserDefaults.standard
  var user_Id:Int!
  var type:Int!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
     loadMoreData()
    setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadMoreData()
    self.addNotificationChangeLanguage()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
     self.moreTableView.reloadData()
    NotificationCenter.default.removeObserver(self)
  }
  
  func addNotificationChangeLanguage(){
    NotificationCenter.default.addObserver(self, selector: #selector(doOnLangaue), name: NSNotification.Name(rawValue: Domains.notificationLanguage), object: nil)
  }
  
  @objc func doOnLangaue(){
    self.moreTableView.reloadData()
  }
  func loadMoreData(){
    moreList = ["",
                LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.apointmentLb.rawValue, comment: ""),
                LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.awardpointLb.rawValue, comment: ""),
                LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.historyLb.rawValue, comment: ""),
                LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.settingLb.rawValue, comment: ""),
                LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.aboutUsLb.rawValue, comment: ""),
                LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.logoutLb.rawValue, comment: "")]

  
    moreImageList = [#imageLiteral(resourceName: "calendar-white"),#imageLiteral(resourceName: "calendar-white"),#imageLiteral(resourceName: "reward"),#imageLiteral(resourceName: "history"),#imageLiteral(resourceName: "settings-white"),#imageLiteral(resourceName: "about-us"),#imageLiteral(resourceName: "logout")]
    self.moreTableView.reloadData()
  
  }
  func setupTableView(){
       moreTableView.dataSource = self
       moreTableView.delegate = self
  }
}

extension MoreViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moreList.count
  }
  
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 240
    }else {
      return UITableViewAutomaticDimension
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
      header.configureHeader()
      return header
    }else {
      let moreContent = tableView.dequeueReusableCell(withIdentifier: "MoreContentCell", for: indexPath) as! MoreContentCell
      
      moreContent.iconMoreImage.image = moreImageList[indexPath.row]
      moreContent.titleMoreLabel.text = moreList[indexPath.row]
      
      return moreContent
    }
  }
  
   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    return footerView
  }
  
   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }
  
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
    
    switch indexPath.row {
    case 0:
      print("header")
    case 1:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Apointment)
      let appointment = storyboard.instantiateViewController(withIdentifier: "ApointmentCalendarViewController") as! ApointmentCalendarViewController
      let userId = userDefault.object(forKey: UserKeys.userId.rawValue) as! Int
      appointment.userId = userId
      navigationController?.pushViewController(appointment, animated: true)
      
      
    case 2:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Rewardpoint)
      let awardPoint = storyboard.instantiateViewController(withIdentifier: "RewardPointViewController") as! RewardPointViewController
      awardPoint.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(awardPoint, animated: true)
      
      
    case 3:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .History)
      let history = storyboard.instantiateViewController(withIdentifier: "TransitionHistoryViewController") as! TransitionHistoryViewController
      history.hidesBottomBarWhenPushed = true
      navigationController?.present(history, animated: true)
      
    case 4:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Setting)
      let setting = storyboard.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
      setting.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(setting, animated: true)
      
    case 5:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .AboutUs)
      let aboutUs = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
      aboutUs.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(aboutUs, animated: true)
      
    case 6:
      //  do {
      // Set the view to the login screen after signing out
      userDefault.removeObject(forKey: SignInKeys.SignedIn.rawValue)
      userDefault.removeObject(forKey: UserKeys.userProfile.rawValue)
      userDefault.removeObject(forKey: UserKeys.userProfileEmail.rawValue)
      userDefault.removeObject(forKey: UserKeys.type.rawValue)
      userDefault.removeObject(forKey: "budge")
      
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.setupRootViewController()
      appDelegate.countBudge = 0
      
      break
    default:
      print("nothing")
    }
  }
  
}
