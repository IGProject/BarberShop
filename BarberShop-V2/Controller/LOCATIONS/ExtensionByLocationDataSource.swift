//
//  ExtensionByLocationDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/29/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

extension ByLocationViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return mLocatonResult.results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let byLocationCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ByLocationCollectionCell", for: indexPath) as! ByLocationCollectionCell
    
    byLocationCell.configure(data: mLocatonResult.results[indexPath.item])
    byLocationCell.delegate = self
    return byLocationCell
  }
  
}

