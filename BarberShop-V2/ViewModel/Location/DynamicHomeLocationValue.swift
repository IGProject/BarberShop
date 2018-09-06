//
//  DynamicHomeLocationValue.swift
//  BarberShop-V2
//
//  Created by User on 6/23/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionHomeLocationHandler = (() -> Void)

class DynamicHomeLocationValue<H> {
    var value: H {
        didSet{
            self.notify()
        }
    }
    private var homeLocationObserver = [String: CompletionHomeLocationHandler]()
    
    
    init(_ value: H){
        self.value = value
    }
    
    public func addHomeLocationObservers(_ observer:NSObject, completionHandler:@escaping CompletionHomeLocationHandler){
        homeLocationObserver[observer.description] = completionHandler
        
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionHomeLocationHandler){
        self.addHomeLocationObservers(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        homeLocationObserver.forEach({ $0.value() })
        
    }
    deinit {
        homeLocationObserver.removeAll()
    }
}
