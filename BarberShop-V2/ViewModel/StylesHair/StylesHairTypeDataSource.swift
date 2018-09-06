//
//  StylesHairTypeDataSource.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit

class GenericStyleHairTypesDataSource<TYPE>: NSObject {
    var data: DynamicStyleHairTypesValue<[TYPE]> = DynamicStyleHairTypesValue([])
}

class StylesHairTypeDataSource: GenericStyleHairTypesDataSource<HairStyleModel>,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let styleHairTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "hairTypeCell", for: indexPath) as! HairstyleTypeCollectionViewCell
        
        let arrayOfstyleHairType = self.data.value[indexPath.row]
        styleHairTypeCell.shapeNameLabel.text = arrayOfstyleHairType.shape?.shape_name
        return styleHairTypeCell
    }
    
    
}
