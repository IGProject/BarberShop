//
//  NotificationCell.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell,ConfigurableCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
  
  func configure(data: Booking) {
    
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "dd"
    
    let timeFormate = DateFormatter()
    timeFormate.dateFormat = "HH:mm a"
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    
    let dateString = dateStringFormatter.date(from: data.workTime)
    let timeWorking = timeFormate.string(from: dateString!)
    
    timeLabel.text = timeWorking
    teamNameLabel.text = data.team.team
    locationLabel.text = data.location.location
    serviceLabel.text = data.service.service
    statusLabel.text = data.statusNote
    
    
  }
   
}
