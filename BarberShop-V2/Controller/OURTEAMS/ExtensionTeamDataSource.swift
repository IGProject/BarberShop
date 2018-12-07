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
    
    listTeamCell.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
    listTeamCell.layer.cornerRadius = 5
    listTeamCell.layer.borderWidth = 0.5
    
    return listTeamCell
  
  }
}
