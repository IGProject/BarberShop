//
//  BarberPopupViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class BarberPopupViewController: UIViewController {
    @IBOutlet weak var barberPopUpTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func cancelTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

