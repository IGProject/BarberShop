//
//  DynamicUserValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionUserHandler = (() -> Void)
class DynamicUserEmailViewValue<U> {
    var value : U {
        didSet {
            self.notify()
        }
    }
    
    private var userObservers = [String: CompletionUserHandler]()
    
    init(_ value: U) {
        self.value = value
    }
    
    public func addUserObserver(_ observer: NSObject, completionHandler: @escaping CompletionUserHandler) {
        userObservers[observer.description] = completionHandler
    }
    
    //Observable
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionUserHandler) {
        self.addUserObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        userObservers.forEach({ $0.value() })
    }
    
    deinit {
        userObservers.removeAll()
    }
}
