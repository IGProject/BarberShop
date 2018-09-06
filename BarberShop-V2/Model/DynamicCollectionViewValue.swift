//
//  DynamicCollectionViewValue.swift
//  BarberShop-V2
//
//  Created by User on 5/30/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionHandler = (() -> Void)
class DynamicCollectionViewValue<T> {
    var value : T {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init(_ value: T) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value() })
    }
    
    deinit {
        observers.removeAll()
    }
}
