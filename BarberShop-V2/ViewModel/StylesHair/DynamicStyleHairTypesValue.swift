//
//  DynamicStyleHairTypesValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionStyleHairTypeHandler = (() -> Void)

class DynamicStyleHairTypesValue<TYPE>{
    var value: TYPE {
        didSet{
            self.notify()
        }
    }
    private var hairTypeObserver = [String: CompletionStyleHairTypeHandler]()
    
    init(_ value: TYPE){
        self.value = value
    }
    
    public func addHairTypeObservers(_ observer:NSObject, completionHandler:@escaping CompletionStyleHairTypeHandler){
        hairTypeObserver[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionStyleHairTypeHandler){
        self.addHairTypeObservers(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        hairTypeObserver.forEach({ $0.value() })
    }
    deinit {
        hairTypeObserver.removeAll()
    }
}
