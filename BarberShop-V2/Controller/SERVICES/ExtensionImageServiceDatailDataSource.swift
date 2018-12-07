//
//  ExtensionImageServiceDatailDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/29/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

extension ServiceDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageDetail.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let imageServiceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceDetailCollectionViewCell", for: indexPath) as! ServiceDetailCollectionViewCell
    
    let url = URL(string: Domains.BaseURL)
    let imageUrls = url?.appendingPathComponent(self.imageDetail[indexPath.item])
    imageServiceCell.serviceDetailImageView.kf.setImage(with: imageUrls)
    return imageServiceCell
  }
}
