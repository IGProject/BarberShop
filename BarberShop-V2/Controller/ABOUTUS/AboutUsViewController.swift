//
//  AboutUsViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupClearNavigation()
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
        
    }
}
