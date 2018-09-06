//
//  ServicesDataSource.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit

class GenericServiceDataSource<S>: NSObject {
    var data: DynamicServiceValue<[S]> = DynamicServiceValue([])
}

class ServiceDatasource:GenericServiceDataSource<ServicesDetails>,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let serviceCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath) as! ServiceCollectionViewCell
        
        let arrayOfService = self.data.value[indexPath.row]
        
        serviceCollectionCell.des_service.text = arrayOfService.description
        serviceCollectionCell.price_service.text = arrayOfService.price
        serviceCollectionCell.title_service.text = arrayOfService.title
    
        return serviceCollectionCell
    }
}
