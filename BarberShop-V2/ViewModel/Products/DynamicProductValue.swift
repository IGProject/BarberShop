//
//  DynamicProductValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionProductsHandler = (() -> Void)
class DynamicProductsValue<P> {
    var value: P {
        didSet{
            self.notify()
        }
    }
    private var productsObServers = [String: CompletionProductsHandler]()
    
    init(_ value: P) {
        self.value = value
    }
    
    public func addProductObServer(_ observer:NSObject, completionHandler:@escaping CompletionProductsHandler){
        productsObServers[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionProductsHandler){
        self.addProductObServer(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        productsObServers.forEach({ $0.value() })
    }
    deinit {
        productsObServers.removeAll()
    }
    
}
