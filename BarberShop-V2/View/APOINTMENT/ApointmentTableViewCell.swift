//
//  ApointmentTableViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ApointmentTableViewCell: UITableViewCell,ConfigurableCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
  
  func configure(data: Booking) {
  
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "dd MMM"
    
    let timeFormate = DateFormatter()
    timeFormate.dateFormat = "HH:mm a"
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let dateString = dateStringFormatter.date(from: data.workTime ?? ""){
      let dateWorking = dateFormate.string(from: dateString)
      let timeWorking = timeFormate.string(from: dateString)
      
      dateLabel.text = dateWorking
      timeLabel.text = timeWorking
    }
    
    statusLabel.text = data.statusNote
    teamNameLabel.text = data.team.team
  }

}
