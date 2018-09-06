//
//  StylesHairViewModel.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

class StylesHairViewModel {
    weak var dataSource: GenericStylesHairDataSource<HairStyleModel>?
    weak var service: ServiceNetworkProtocol?
    
    init(service:ServiceNetworkProtocol = GenericNetworkService.shared,dataSource: GenericStylesHairDataSource<HairStyleModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    
}




