//
//  StoryboardIdentifiable.swift
//  BarberShop-V2
//
//  Created by User on 6/9/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
protocol StoryboardBased {
    static var storyboardIdentifier: String { get }
}

extension StoryboardBased where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
