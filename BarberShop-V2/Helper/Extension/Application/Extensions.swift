//
//  Extensions.swift
//  BarberShop-V2
//
//  Created by User on 9/4/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
