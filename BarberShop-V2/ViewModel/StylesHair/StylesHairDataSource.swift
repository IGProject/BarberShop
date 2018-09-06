//
//  StylesHairDataSource.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
class GenericStylesHairDataSource<H>: NSObject {
    var data: DynamicStylesHairValue<[H]> = DynamicStylesHairValue([])
}

class StylesHairDataSource: GenericStylesHairDataSource<HairStyleModel>,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let stylesHairCell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! HairstyleCollectionViewCell
         let arrayOfStylesHair = self.data.value[indexPath.row]
        stylesHairCell.shapeNameLabel.text = arrayOfStylesHair.shape?.shape_name
        return stylesHairCell
    }
    
    
    
}
