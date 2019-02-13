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
    @IBOutlet weak var userTitleLabel: UILabel!
  @IBOutlet weak var phoneTitleLabel: UILabel!
  @IBOutlet weak var bookingBtn: RoundButton!
  
  var dataItem:Teams.Results? = nil
  var delegate: TeamBookingCellDelegate?
  
  let url = URL(string: Domains.BaseURL)!
  
  func configure(data team: Teams.Results) {
    
    imageOurTeam.contentMode = .scaleAspectFill
    imageOurTeam.frame = CGRect(x: 0, y: 0, width: imageOurTeam.bounds.size.width, height: imageOurTeam.bounds.size.height)
    
      let imageUrl = url.appendingPathComponent(team.team_profile)
      let teamImage = #imageLiteral(resourceName: "not_image")
      self.imageOurTeam.kf.setImage(with: imageUrl, placeholder:teamImage)
      self.usernameTeam.text = team.username
      self.phoneTeam.text = team.phone
    
    dataItem = team
    
    //Title
    self.userTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: OurTeam.userNameLb.rawValue, comment: "")
    self.phoneTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: OurTeam.phoneNumLb.rawValue, comment: "")
    
    self.bookingBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: OurTeam.bookBtnTeam.rawValue, comment: ""), for: .normal)
    
  }
  
  @IBAction func BookingTeamTapped(_ sender: RoundButton) {
    
    delegate?.didTapTeamBooking(self,dataItem!)
  }
  
}
