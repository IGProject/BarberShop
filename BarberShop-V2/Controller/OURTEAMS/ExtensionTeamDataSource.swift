//
//  ExtensionTeamDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/29/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
extension OurTeamBarberViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemsTeam.results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let listTeamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OurTeamCollectionCell", for: indexPath) as! OurTeamCollectionCell
   
    listTeamCell.configure(data: itemsTeam.results[indexPath.item])
    listTeamCell.delegate = self
    
    listTeamCell.contentMode = .scaleAspectFill
    
    
    return listTeamCell
  
  }
}
