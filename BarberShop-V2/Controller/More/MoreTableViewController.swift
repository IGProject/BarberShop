//
//  MoreTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 11/16/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
class MoreTableViewController: UITableViewController {

  @IBOutlet weak var imageProfile: RoundedImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  let userDefault = UserDefaults.standard
  var user_Id:Int!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      
      setupClearNavigation()
      setupProfile()
    }
  private func  setupProfile(){
  
  let username = userDefault.object(forKey: UserKeys.usernameText.rawValue) as? String
    
  let imageUrl = userDefault.object(forKey: UserKeys.userProfile.rawValue) as? String
    
  let type = userDefault.object(forKey: UserKeys.type.rawValue) as? Int
    
  let urlImage = URL(string: imageUrl!)!
  let url = URL(string: Domains.BaseURL)!
    
    switch type {
    case 3,4:
      
      imageProfile.kf.setImage(with: urlImage)
    default:
      
      let urlProfile = url.appendingPathComponent(imageUrl!)
      imageProfile.kf.setImage(with: urlProfile)
    }
  
    usernameLabel.text = username
  
    
  }
 private func setupClearNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  }
  

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 1:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Apointment)
      let appointment = storyboard.instantiateViewController(withIdentifier: "ApointmentCalendarViewController") as! ApointmentCalendarViewController
      let userId = userDefault.object(forKey: UserKeys.userId.rawValue) as! Int
      appointment.userId = userId
    
      navigationController?.pushViewController(appointment, animated: true)
      break

    case 2:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Rewardpoint)
      let awardPoint = storyboard.instantiateViewController(withIdentifier: "RewardPointViewController") as! RewardPointViewController
      navigationController?.pushViewController(awardPoint, animated: true)
      break
      
    case 3:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Hairstyle)
      let hairStyle = storyboard.instantiateViewController(withIdentifier: "HairStylesViewController") as! HairStylesViewController
      navigationController?.pushViewController(hairStyle, animated: true)
      break

    case 4:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Product)
      let product = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
      navigationController?.pushViewController(product, animated: true)
      break

    case 5:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Setting)
      let setting = storyboard.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
      navigationController?.pushViewController(setting, animated: true)
      break

    case 6:
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .AboutUs)
      let aboutUs = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
      navigationController?.pushViewController(aboutUs, animated: true)
      
      break
    case 7:
      userDefault.removeObject(forKey: SignInKeys.SignedIn.rawValue)
      self.navigationController?.popToRootViewController(animated: true)
      break

    default:
      print("nothing")
    }
 }
}
