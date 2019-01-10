//
//  HistoryCell.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell,ConfigurableCell{

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
  
  func configure(data: Booking) {
    
    let timeFormate = DateFormatter()
    timeFormate.dateFormat = "hh:mm a"
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy hh:mm"
    dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    
    if let dateString = dateStringFormatter.date(from: data.workTime!) {
      let timeWorking = timeFormate.string(from: dateString)
      timeLabel.text = timeWorking
    }
    
    teamNameLabel.text = data.team.team
    locationLabel.text = data.location.location
    serviceLabel.text = data.service.service
    statusLabel.text = data.statusNote
    
  }
}
