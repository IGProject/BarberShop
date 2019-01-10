//
//  NotificationCell.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
class NotificationCell: UITableViewCell,ConfigurableCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var teamNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var teamProfileImg: UIImageView!
  
  
  
  func configure(data: NotificationAlertResponse) {
    
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "dd"
    
    let timeFormate = DateFormatter()
    timeFormate.dateFormat = "HH:mm a"
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    
    let url = URL(string: Domains.BaseURL)!
    
    titleLabel.text = data.results[0].title
    bodyLabel.text = data.results[0].body
    typeLabel.text = data.results[0].type
   // teamNameLabel.text = data.results[0].actionTeamBy.username
    let urlImage = url.appendingPathComponent(data.results[0].actionTeamBy.teamProfile)
    
    teamProfileImg.kf.setImage(with: urlImage)
   // let dateString = dateStringFormatter.date(from: data.results[0].createdAt)
//
//    let timeWorking = timeFormate.string(from: dateString!)
//
 //   dateLabel.text = data.results[0].createdAt.trimmingCharacters(in: .illegalCharacters)

//    
    
  }
   
}
