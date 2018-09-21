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
        setupClearNavigation()
        configContentPager()
    }
    
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 2/255, green: 86/255, blue: 153/255, alpha: 1.0)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 2/255, green: 86/255, blue: 153/255, alpha: 1.0)
    }
    
    
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
         navigationController?.dismiss(animated: true)
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
        segmentedPager.segmentedControl.backgroundColor = UIColor.init(red: 2/255, green: 86/255, blue: 153/255, alpha: 1.0)
        segmentedPager.segmentedControl.titleTextAttributes = [kCTForegroundColorAttributeName : UIColor(displayP3Red: 142/255, green: 174/255, blue: 204/255, alpha: 1)]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["By Location","Nearest"][index]
    }
}

