//
//  HeaderTableViewCell.swift
//  BarberShop-V2
//
//  Created by User on 1/5/19.
//  Copyright © 2019 minea. All rights reserved.
//

import UIKit
import Kingfisher
class HeaderTableViewCell: UITableViewCell {

  @IBOutlet weak var imageProfile: RoundedImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  func configureHeader(){
    let username = UserDefaults.standard.object(forKey: UserKeys.usernameText.rawValue) as? String
    let imageUrl = UserDefaults.standard.object(forKey: UserKeys.userProfile.rawValue) as? String
    let type = UserDefaults.standard.object(forKey: UserKeys.type.rawValue) as? Int
    
    let urlImage = URL(string: imageUrl!)!
    let url = URL(string: Domains.BaseURL)!
    if  type != nil {
      switch type {
      case 3,4:
        imageProfile.kf.setImage(with: urlImage)
      default:
        let urlProfile = url.appendingPathComponent(imageUrl!)
        imageProfile.kf.setImage(with: urlProfile)
      }
    }
    usernameLabel.text = username
  }
}
