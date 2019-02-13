//
//  HeaderCell.swift
//  BarberShop-V2
//
//  Created by User on 2/13/19.
//  Copyright © 2019 minea. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
  
  @IBOutlet weak var imageProfile: RoundedImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  func configureHeader(){
    let username = UserDefaults.standard.object(forKey: UserKeys.usernameText.rawValue) as? String
    let imageUrl = UserDefaults.standard.object(forKey: UserKeys.userProfile.rawValue) as? String
    let imageUrlEmail = UserDefaults.standard.object(forKey: UserKeys.userProfileEmail.rawValue) as? String
    let type = UserDefaults.standard.object(forKey: UserKeys.type.rawValue) as? Int
    
    
    
    let url = URL(string: Domains.BaseURL)!
    let urlProfile = url.appendingPathComponent(imageUrlEmail ?? "")
    imageProfile.kf.setImage(with: urlProfile,placeholder: #imageLiteral(resourceName: "avatar-user"))
    
    if  type != nil {
      switch type {
      case 3,4:
        let urlImage = URL(string: imageUrl ?? "")
        imageProfile.kf.setImage(with: urlImage,placeholder: #imageLiteral(resourceName: "avatar-user"))
        print("urlIMageSocial:\(String(describing: urlImage))")
      default:
        print("nothings")
      }
    }
    usernameLabel.text = username
  }
}
