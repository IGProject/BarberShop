//
//  ServiceCollectionViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher

protocol ServiceBookingCellDelegate {
  func didTapServiceBooking(_ T: ServiceCollectionCell,_ data:Services.Results)
}

class ServiceCollectionCell: UICollectionViewCell,ConfigurableCell {
    @IBOutlet weak var image_service: UIImageView!
    @IBOutlet weak var title_service: UILabel!
    @IBOutlet weak var price_service: UILabel!
    @IBOutlet weak var des_service: UILabel!
    @IBOutlet weak var bookingBtn: RoundButton!
  
  
  @IBOutlet weak var serviceTitleLabel: UILabel!
  @IBOutlet weak var descripTitleLabel: UILabel!
  @IBOutlet weak var pricesTitleLabel: UILabel!
  @IBOutlet weak var currencyLabel: UILabel!
  
  var dataService:Services.Results? = nil
  var delegate: ServiceBookingCellDelegate?
  
  let serviceEndPoint = URL(string: Domains.BaseURL)
  
  func configure(data services: Services.Results) {
    let urlImage = serviceEndPoint?.appendingPathComponent(services.seva_profile)
    self.image_service.kf.setImage(with: urlImage)
    self.title_service.text = services.title
    self.price_service.text = services.price
    self.des_service.text = services.description
    self.dataService = services
    
    self.serviceTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ServiceBarber.serviceLb.rawValue, comment: "")
    
    self.descripTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ServiceBarber.descriptLb.rawValue, comment: "")
    
    self.pricesTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ServiceBarber.pricesLb.rawValue, comment: "")
    
    self.currencyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ServiceBarber.dollarLb.rawValue, comment: "")
    
    self.bookingBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: ServiceBarber.bookingBtn.rawValue, comment: ""), for: .normal)

  }
  
  @IBAction func ServiceBookingTapped(_ sender: RoundButton) {
    delegate?.didTapServiceBooking(self,dataService!)
  }
  
}
