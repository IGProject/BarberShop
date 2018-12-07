//
//  ContainerHistoryViewController.swift
//  BarberShop-V2
//
//  Created by User on 7/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import MXSegmentedPager
class ContainerHistoryViewController: MXSegmentedPagerController {
 @IBOutlet var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configContentPager()
      setupClearNavigation()
    }
  func setupClearNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
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
        segmentedPager.segmentedControl.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
        segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(displayP3Red: 142/255, green: 174/255, blue: 204/255, alpha: 1),NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 14) ??
            UIFont.systemFont(ofSize: 14)]

        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["Transition History","Notification"][index]
    }
}
