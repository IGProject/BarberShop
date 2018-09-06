//
//  DynamicBarbersValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionBarbersHandler = (() -> Void)
class DynamicBarbersValue<B> {
    var value: B {
        didSet{
            self.notify()
        }
    }
    private var barbersObServers = [String: CompletionBarbersHandler]()
    
    init(_ value: B) {
        self.value = value
    }
    
    public func addServiceObServer(_ observer:NSObject, completionHandler:@escaping CompletionBarbersHandler){
        barbersObServers[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionBarbersHandler){
        self.addServiceObServer(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        barbersObServers.forEach({ $0.value() })
    }
    deinit {
        barbersObServers.removeAll()
    }
    
}
