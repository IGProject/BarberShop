//
//  BarbersViewModel.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

class BarbersViewModel {
    weak var dataSource: GenericBarbersDataSource<TeamDetails>?
    weak var service: ServiceNetworkProtocol?
    
    init(service:ServiceNetworkProtocol = GenericNetworkService.shared,dataSource: GenericBarbersDataSource<TeamDetails>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    public func getData(){
        
    }
}
