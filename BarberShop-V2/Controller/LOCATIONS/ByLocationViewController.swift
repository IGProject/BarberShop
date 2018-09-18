//
//  ByLocationViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ByLocationViewController: UIViewController {
    @IBOutlet weak var collectionViewLocation: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ByLocationViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    
}
