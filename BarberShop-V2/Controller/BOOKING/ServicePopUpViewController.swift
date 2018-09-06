//
//  ServicePopUpViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ServicePopUpViewController: UIViewController{

    @IBOutlet weak var serviceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
   
    @IBAction func cancelTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func saveTapped(_ sender: Any) {
        
    }
    
}
