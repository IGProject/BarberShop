//
//  HomeLocationViewModel.swift
//  BarberShop-V2
//
//  Created by User on 6/23/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
class HomeLocationViewModel {
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //----------------------------------------------------------------
    
    private lazy var nearByViewController: NearestViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(storyboard: .Location)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController() as! NearestViewController
        
        // Add View Controller as Child View Controller
       // self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var byLocationsViewController: ByLocationViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(storyboard: .Location)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController() as! ByLocationViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        return viewController
    }()
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Abstract Method
    //----------------------------------------------------------------
    
    static func viewController() -> HomeLocationViewController {
        return UIStoryboard.init(storyboard: .Location).instantiateInitialViewController() as! HomeLocationViewController
    }
    
//    private func updateView() {
//        if segmentControlLocation.selectedSegmentIndex == 0 {
//            remove(asChildViewController: byLocationsViewController)
//            add(asChildViewController: nearByViewController)
//        } else {
//            remove(asChildViewController: nearByViewController)
//            add(asChildViewController: byLocationsViewController)
//        }
//    }
    
    //----------------------------------------------------------------
}
