//
//  UIStoryboard+Storyboards.swift
//  BarberShop-V2
//
//  Created by User on 6/9/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

extension UIStoryboard {
    /// The uniform place where we state all the storyboard we have in our application
    enum Storyboard: String {
        case main
        case signin
        case signup
        case home
        case booking
        case location
        case service
        case hairstyle
        case product
        case ourteam
        case appointment
        case setting
        case history
        case launchscreen
        case aboutus
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardBased {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
