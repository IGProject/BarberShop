//
//  OurTeamCollectionViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher

protocol TeamBookingCellDelegate {
  func didTapTeamBooking(_ T: OurTeamCollectionCell,_ data:Teams.Results)
}

class OurTeamCollectionCell: UICollectionViewCell,ConfigurableCell {
  
    @IBOutlet weak var imageOurTeam: UIImageView!
    @IBOutlet weak var usernameTeam: UILabel!
    @IBOutlet weak var phoneTeam: UILabel!
    @IBOutlet weak var bookingBtn: RoundButton!
  var dataItem:Teams.Results? = nil
  var delegate: TeamBookingCellDelegate?
  
  let url = URL(string: Domains.BaseURL)!
  
  func configure(data team: Teams.Results) {
    let imageUrl = url.appendingPathComponent(team.team_profile)
    self.imageOurTeam.kf.setImage(with: imageUrl)
    self.usernameTeam.text = team.username
    self.phoneTeam.text = team.phone
    dataItem = team
  }
  
  @IBAction func BookingTeamTapped(_ sender: RoundButton) {
    
    delegate?.didTapTeamBooking(self,dataItem!)
  }
  
}
