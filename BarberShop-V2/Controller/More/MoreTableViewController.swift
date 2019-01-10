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
  
  var moreList = ["Apointments","Award Point","History","Hair Styles","Products","Settings","About Us","Logout"]
  
  var moreImageList = [#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style"),#imageLiteral(resourceName: "hair-style")]
  
  override func viewDidLoad() {
        super.viewDidLoad()
      setupClearNavigation()
      setupProfile()
    }
  private func  setupProfile(){
  
//  let username = userDefault.object(forKey: UserKeys.usernameText.rawValue) as? String
//
//  let imageUrl = userDefault.object(forKey: UserKeys.userProfile.rawValue) as? String
//
//    type = userDefault.object(forKey: UserKeys.type.rawValue) as? Int
//
//  let urlImage = URL(string: imageUrl!)!
//  let url = URL(string: Domains.BaseURL)!
//    if  type != nil {
//      switch type {
//      case 3,4:
//        imageProfile.kf.setImage(with: urlImage)
//      default:
//        let urlProfile = url.appendingPathComponent(imageUrl!)
//        imageProfile.kf.setImage(with: urlProfile)
//      }
    
//      self.apointmentLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.apointmentLb.rawValue, comment: "")
//
//      self.awardpointLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.awardpointLb.rawValue, comment: "")
//
//      self.historyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.historyLb.rawValue, comment: "")
//
//      self.hairstyleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.hairstyleLb.rawValue, comment: "")
//
//       self.productLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.productLb.rawValue, comment: "")
//
//      self.settingLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.settingLb.rawValue, comment: "")
//
//      self.aboutUsLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.aboutUsLb.rawValue, comment: "")
//
//      self.logoutLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.logoutLb.rawValue, comment: "")
//
//
//    }
//
//
//    usernameLabel.text = username
//
    
  }
  
 private func setupClearNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerSection = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
    headerSection.configureHeader()
    return headerSection
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 245
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moreList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let moreContent = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
    
    moreContent.iconMoreImage.image = moreImageList[indexPath.row]
    moreContent.titleMoreLabel.text = moreList[indexPath.row]
    return moreContent
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
    
    switch indexPath.row {
    case 0:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Apointment)
      let appointment = storyboard.instantiateViewController(withIdentifier: "ApointmentCalendarViewController") as! ApointmentCalendarViewController
      let userId = userDefault.object(forKey: UserKeys.userId.rawValue) as! Int
      appointment.userId = userId

      navigationController?.pushViewController(appointment, animated: true)
    

    case 1:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Rewardpoint)
      let awardPoint = storyboard.instantiateViewController(withIdentifier: "RewardPointViewController") as! RewardPointViewController
      navigationController?.pushViewController(awardPoint, animated: true)
     
      
    case 2:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .History)
      let boooking = storyboard.instantiateViewController(withIdentifier: "ContainerHistoryViewController") as! ContainerHistoryViewController
      navigationController?.pushViewController(boooking, animated: true)
    
    
    case 3:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Hairstyle)
      let hairStyle = storyboard.instantiateViewController(withIdentifier: "HairStylesViewController") as! HairStylesViewController
      navigationController?.pushViewController(hairStyle, animated: true)
     
    case 4:
     
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Product)
      let product = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
      navigationController?.pushViewController(product, animated: true)

    case 5:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Setting)
      let setting = storyboard.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
      navigationController?.pushViewController(setting, animated: true)
      
    case 6:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .AboutUs)
      let aboutUs = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
      navigationController?.pushViewController(aboutUs, animated: true)
    
    case 7:
     break
    default:
      print("nothing")
    }
 }
  
}
