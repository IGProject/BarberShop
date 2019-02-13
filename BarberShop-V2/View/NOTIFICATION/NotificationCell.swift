//
//  NotificationCell.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
class NotificationCell: UITableViewCell{

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var teamProfileImg: UIImageView!
  
  @IBOutlet weak var backgroundChange: CustomUIView!
  
  @IBOutlet weak var titleLb: UILabel!
  @IBOutlet weak var bodyLb: UILabel!
  @IBOutlet weak var typeLb: UILabel!
  
  func configure(data:Result) {
    
    
    let url = URL(string: Domains.BaseURL)!

    titleLabel.text = data.title
    bodyLabel.text = data.body
    typeLabel.text = data.type

    let urlImage = url.appendingPathComponent(data.actionTeamBy.teamProfile)

    teamProfileImg.kf.setImage(with: urlImage)
 
    titleLb.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: HistoryTable.titleLb.rawValue, comment: "")
    
    bodyLb.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: HistoryTable.bodyLb.rawValue, comment: "")
    
    typeLb.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: HistoryTable.typeLb.rawValue, comment: "")
    
  }
   
}
