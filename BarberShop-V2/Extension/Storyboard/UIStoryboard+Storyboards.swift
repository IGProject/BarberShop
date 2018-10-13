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
        case Rewardpoint
        case SignIn
        case SignUp
        case Home
        case Booking
        case Location
        case Service
        case Hairstyle
        case Product
        case Ourteam
        case Appointment
        case Setting
        case History
        case Launchscreen
        case AboutUs
        
        var filename: String {
            return rawValue
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
