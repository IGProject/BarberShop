//
//  MoreTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 11/16/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
import FacebookCore
import FacebookLogin
import Firebase
import GoogleSignIn
class MoreTableViewController: UITableViewController {

  @IBOutlet weak var apointmentLabel: UILabel!
  @IBOutlet weak var awardpointLabel: UILabel!
  @IBOutlet weak var historyLabel: UILabel!
  @IBOutlet weak var hairstyleLabel: UILabel!
  @IBOutlet weak var productLabel: UILabel!
  @IBOutlet weak var settingLabel: UILabel!
  @IBOutlet weak var aboutUsLabel: UILabel!
  @IBOutlet weak var logoutLabel: UILabel!
  
  
  let userDefault = UserDefaults.standard
  var user_Id:Int!
  var type:Int!
  
  var moreList = ["",
                  LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.apointmentLb.rawValue, comment: ""),
                  LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.awardpointLb.rawValue, comment: ""),
                  LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.historyLb.rawValue, comment: ""),
                  LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.settingLb.rawValue, comment: ""),
                  LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.aboutUsLb.rawValue, comment: ""),
                  LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.logoutLb.rawValue, comment: "")]
  
  var moreImageList = [#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style")]
  
  override func viewDidLoad() {
        super.viewDidLoad()
    // setupClearNavigation()
    }
 
  func setupClearNavigation() {
 
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    self.navigationController?.navigationBar.shadowImage = UIImage()
//    self.navigationController?.navigationBar.backgroundColor = .white
//    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  
  }
  

  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moreList.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 240
    }else {
      return 50
    }
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      let header = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
      header.configureHeader()
      return header
    }else {
      let moreContent = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
      moreContent.iconMoreImage.image = moreImageList[indexPath.row]
      moreContent.titleMoreLabel.text = moreList[indexPath.row]
       return moreContent
    }
    
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
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
      navigationController?.pushViewController(history, animated: true)

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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setupRootViewController()
     // } catch let signOutError as NSError {
       // print ("Error signing out: \(signOutError)")
     // }
     break
    default:
      print("nothing")
    }
 }
  
}
