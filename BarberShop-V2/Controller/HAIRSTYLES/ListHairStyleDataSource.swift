//
//  ListHairStyleDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/27/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ListHairStyleDataSource: NSObject,UICollectionViewDataSource {
  var listStyleHair = StyleHair(length:0,results:[])
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listStyleHair.results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       let shapeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HairstyleCollectionCell", for: indexPath) as! HairstyleCollectionCell
    
    shapeCell.configure(data: listStyleHair.results[indexPath.item])
    
    shapeCell.layer.borderColor = UIColor(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
    shapeCell.layer.cornerRadius = 5
    shapeCell.layer.borderWidth = 0.5
    
    return shapeCell
  }
  
  
}
