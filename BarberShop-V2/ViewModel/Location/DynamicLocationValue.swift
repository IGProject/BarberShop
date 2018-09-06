//
//  DynamicLocationValue.swift
//  BarberShop-V2
//
//  Created by User on 6/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionLocationHandler = (() -> Void)

class DynamicLocationValue<L> {
    var value: L {
        didSet{
            self.notify()
        }
    }
    private var locationObserver = [String: CompletionLocationHandler]()
   
    
    init(_ value: L){
        self.value = value
    }
    
    public func addlocationObservers(_ observer:NSObject, completionHandler:@escaping CompletionLocationHandler){
        locationObserver[observer.description] = completionHandler
        
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionLocationHandler){
        self.addlocationObservers(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        locationObserver.forEach({ $0.value() })
       
    }
    deinit {
        locationObserver.removeAll()
    }
}

