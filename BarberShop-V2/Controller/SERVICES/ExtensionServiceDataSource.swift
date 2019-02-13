//
//  ExtensionServiceDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/29/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
extension ServiceViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemsService.results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionCell", for: indexPath) as! ServiceCollectionCell
    
    serviceCell.configure(data: itemsService.results[indexPath.item])
    serviceCell.delegate = self
    
//    serviceCell.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
//    serviceCell.layer.cornerRadius = 5
//    serviceCell.layer.borderWidth = 0.5
    
    return serviceCell
  }
}
