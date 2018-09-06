//
//  ProductsDataSource.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
class GenericProductsDataSource<P>: NSObject {
    var data: DynamicProductsValue<[P]> = DynamicProductsValue([])
}

class ProductsDataSource: GenericProductsDataSource<ProductDetails>,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! ProductCollectionViewCell
        
        let arrayOfProduct = self.data.value[indexPath.row]
        productsCell.rielLabel.text = arrayOfProduct.price
        productsCell.titleLabel.text = arrayOfProduct.title
        return productsCell
    }
    
    
}
