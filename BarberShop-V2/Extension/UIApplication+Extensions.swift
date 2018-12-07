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

extension UICollectionView {
    func dropShadowBottom(){
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
        self.clipsToBounds = false
        self.layer.masksToBounds = false
    }
}
