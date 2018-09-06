//
//  DynamicServiceValue.swift
//  BarberShop-V2
//
//  Created by User on 6/15/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionServiceTitleHandler = (() -> Void)

class DynamicServiceTitleValue<T>{
    var value: T {
        didSet{
            self.notify()
        }
    }
    private var serviceTitleObServers = [String: CompletionServiceTitleHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addServiceTitleObServer(_ observer:NSObject, completionHandler:@escaping CompletionServiceTitleHandler){
        serviceTitleObServers[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionServiceTitleHandler){
        self.addServiceTitleObServer(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        serviceTitleObServers.forEach({ $0.value() })
    }
    deinit {
        serviceTitleObServers.removeAll()
    }
}
