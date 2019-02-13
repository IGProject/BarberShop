//
//  HomeLocationViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import MXSegmentedPager
class HomeLocationViewController: MXSegmentedPagerController {
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
            segmentedPager.reloadData()
            
        }
        
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorHeight = 2
        segmentedPager.segmentedControl.selectionIndicatorColor = .white
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = UIColor(red: 0/255, green: 105/255, blue: 92/255, alpha: 1.0)
        segmentedPager.segmentedControl.titleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white]
      segmentedPager.reloadData()
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
      
        return [LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.byLocation.rawValue, comment: ""),LocalizationSystem.sharedInstance.localizedStringForKey(key: byLocation.nearest.rawValue, comment: "")][index]
    }
}

