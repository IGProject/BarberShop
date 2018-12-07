//
//  ListProductDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/27/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ListProductDataSource:NSObject,UICollectionViewDataSource {
  
  var itemProduct = Products(length:0,results:[])
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return itemProduct.results.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
    
   
    productCell.configure(data: itemProduct.results[indexPath.item])

    productCell.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
    productCell.layer.cornerRadius = 5
    productCell.layer.borderWidth = 0.5
    
    return productCell
  }
  
  
}
