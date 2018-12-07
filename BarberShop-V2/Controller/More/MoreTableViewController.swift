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
  @IBOutlet weak var emailLabel: UILabel!
  
  let userDefault = UserDefaults.standard
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
      
      setupClearNavigation()
      setupProfile()
    }
  private func  setupProfile(){
  
  let username = userDefault.object(forKey: "usernameText") as? String
  let email = userDefault.object(forKey: "emailText") as? String
  let imageUrl = userDefault.object(forKey: UserKeys.userProfile.rawValue) as? [String]
    imageUrl.map {
      let url = URL(string: Domains.BaseURL)!
      let urlProfile = url.appendingPathComponent($0[0])
      imageProfile.kf.setImage(with: urlProfile)
    }
    usernameLabel.text = username
    emailLabel.text = email
    
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
      let storyboard:UIStoryboard = UIStoryboard(name: "Apointment", bundle: nil)
      let appointment = storyboard.instantiateViewController(withIdentifier: "ApointmentCalendarViewController") as! ApointmentCalendarViewController
      navigationController?.pushViewController(appointment, animated: true)
      break

    case 2:
      let storyboard:UIStoryboard = UIStoryboard(name: "Rewardpoint", bundle: nil)
      let awardPoint = storyboard.instantiateViewController(withIdentifier: "RewardPointViewController") as! RewardPointViewController
      navigationController?.pushViewController(awardPoint, animated: true)
      break
      
    case 3:
      let storyboard:UIStoryboard = UIStoryboard(name: "Hairstyle", bundle: nil)
      let hairStyle = storyboard.instantiateViewController(withIdentifier: "HairStylesViewController") as! HairStylesViewController
      navigationController?.pushViewController(hairStyle, animated: true)
      break

    case 4:
      let storyboard:UIStoryboard = UIStoryboard(name: "Product", bundle: nil)
      let product = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
      navigationController?.pushViewController(product, animated: true)
      break

    case 5:
      let storyboard:UIStoryboard = UIStoryboard(name: "Setting", bundle: nil)
      let setting = storyboard.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
      navigationController?.pushViewController(setting, animated: true)
      break

    case 6:
      let storyboard:UIStoryboard = UIStoryboard(name: "AboutUs", bundle: nil)
      let aboutUs = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
      navigationController?.pushViewController(aboutUs, animated: true)
      break

    case 7:
      print("logout")
      break

    default:
      print("nothing")
    }
 }
}
