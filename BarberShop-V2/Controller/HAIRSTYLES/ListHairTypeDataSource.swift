//
//  ListHairTypeDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/27/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher

class ListHairTypeDataSource: NSObject,UICollectionViewDataSource {
  
  var hairTypeString = [String]()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return hairTypeString.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let url = URL(string: Domains.BaseURL)!
    let urlImage = url.appendingPathComponent(hairTypeString[indexPath.item])
    let imageTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HairTypeCollectionCell", for: indexPath) as! HairTypeCollectionCell
    imageTypeCell.hairTypeImage.kf.setImage(with: urlImage,placeholder: #imageLiteral(resourceName: "no_images_services"))

    imageTypeCell.layer.borderColor = UIColor(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
    imageTypeCell.layer.cornerRadius = 5
    imageTypeCell.layer.borderWidth = 0.5
    return imageTypeCell
  }
  
  
}
