//
//  ContainerServiceViewController.swift
//  BarberShop-V2
//
//  Created by User on 1/29/19.
//  Copyright © 2019 minea. All rights reserved.
//

import UIKit
import MXSegmentedPager
class ContainerServiceViewController: MXSegmentedPagerController {
  @IBOutlet var headerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configContentPager()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.segmentedPager.reloadData()
  }
  
  func configContentPager(){
    if #available(iOS 11.0, *) {
    } else {
      //Parallax Header
      segmentedPager.parallaxHeader.view = headerView
      segmentedPager.parallaxHeader.mode = .fill
      segmentedPager.parallaxHeader.height = 63
    
      
    }
    segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
    segmentedPager.segmentedControl.selectionIndicatorHeight = 2
    segmentedPager.segmentedControl.selectionIndicatorColor = .white
    segmentedPager.segmentedControl.selectionIndicatorLocation = .down
    segmentedPager.segmentedControl.backgroundColor = UIColor(red: 0/255, green: 105/255, blue: 92/255, alpha: 1.0)
    segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 14) ??
      UIFont.systemFont(ofSize: 14)]
    
    segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white]
    
  }
  
  override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
    return [LocalizationSystem.sharedInstance.localizedStringForKey(key:ServiceBarber.tabarServiceTitle.rawValue, comment: ""),
            LocalizationSystem.sharedInstance.localizedStringForKey(key:ProductCollection.productLbKey.rawValue, comment: ""),
            LocalizationSystem.sharedInstance.localizedStringForKey(key:HairStyleCollection.haireStyleLbKey.rawValue, comment: "")][index]
    
  }
}

