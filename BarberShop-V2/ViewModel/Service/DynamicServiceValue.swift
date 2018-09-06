//
//  DynamicServiceValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionServiceHandler = (() -> Void)

class DynamicServiceValue<S>{
    var value: S {
        didSet{
            self.notify()
        }
    }
    private var serviceObServers = [String: CompletionServiceHandler]()
    
    init(_ value: S) {
        self.value = value
    }
    
    public func addServiceObServer(_ observer:NSObject, completionHandler:@escaping CompletionServiceHandler){
        serviceObServers[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionServiceHandler){
        self.addServiceObServer(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        serviceObServers.forEach({ $0.value() })
    }
    deinit {
        serviceObServers.removeAll()
    }
}

