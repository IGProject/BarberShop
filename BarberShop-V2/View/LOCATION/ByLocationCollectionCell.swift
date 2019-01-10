//
//  ByLocationCollectionViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher

protocol LocationBookingCellDelegate {
  func didTapLocationBooking(_ T: ByLocationCollectionCell,_ data:Locations.Results,_ team: Locations.Results)
}


class ByLocationCollectionCell: UICollectionViewCell,ConfigurableCell {
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var addressLocationLabel: UILabel!
    @IBOutlet weak var phoneLocationLabel: UILabel!
    @IBOutlet weak var timeLocationLabel: UILabel!
    @IBOutlet weak var teamNameLocation: UILabel!
  
  
  @IBOutlet weak var nameTitleLabel: UILabel!
  @IBOutlet weak var addressTitleLabel: UILabel!
  @IBOutlet weak var phoneTitleLabel: UILabel!
  @IBOutlet weak var timeTitleLabel: UILabel!
  
  @IBOutlet weak var teamStack: UIStackView!
  
  @IBOutlet weak var bookingBtn: RoundButton!
  
  var dataLocation:Locations.Results? = nil
  var dataTeam:Locations.Results? = nil
  
  var delegate: LocationBookingCellDelegate?
  
    var url = URL(string: Domains.BaseURL)!
  
  func configure(data dataByLocation:Locations.Results) {
    let imageUrl = url.appendingPathComponent(dataByLocation.location_profile)
    self.locationImageView.kf.setImage(with: imageUrl)
    self.addressLocationLabel.text = dataByLocation.address
    self.phoneLocationLabel.text = dataByLocation.phone
    self.timeLocationLabel.text = dataByLocation.work_time
    self.dataLocation = dataByLocation
    
    self.dataTeam = dataByLocation
    
    if dataByLocation.team.count == 0 {
      self.teamStack.isHidden = true
    }
    self.teamNameLocation.text = dataByLocation.team.count == 0 ? "": dataByLocation.team[0].username
    
    self.nameTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.nameLb.rawValue, comment: "")
    
    self.addressTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.addressLb.rawValue, comment: "")
    
    self.phoneTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.phoneLb.rawValue, comment: "")
    
    self.timeTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.timeLb.rawValue, comment: "")
    
    self.bookingBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key:byLocation.bookingBtn.rawValue, comment: ""), for: .normal)
    self.bookingBtn.fontSize = 15
  }
    
  @IBAction func LocationBookingTapped(_ sender: RoundButton) {
    delegate?.didTapLocationBooking(self,dataLocation!,dataTeam!)
  }
}
