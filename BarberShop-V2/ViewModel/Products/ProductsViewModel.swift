//
//  ProductsViewModel.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
class ProductViewModel {
    weak var dataSource: GenericProductsDataSource<ProductDetails>?
    weak var service: ServiceNetworkProtocol?
    
    init(service:ServiceNetworkProtocol = GenericNetworkService.shared,dataSource: GenericProductsDataSource<ProductDetails>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
}
