//
//  ListRewardPointDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/27/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ListRewardPointDataSource:NSObject,UICollectionViewDataSource {
 // var itemRewardPoint = []
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let rewardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardPointCollectionCell", for: indexPath) as! RewardPointCollectionCell
  
    
    rewardCell.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
    rewardCell.layer.cornerRadius = 5
    rewardCell.layer.borderWidth = 0.5
    return rewardCell
  }
}
