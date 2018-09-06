//
//  DynamicHomeValue.swift
//  BarberShop-V2
//
//  Created by User on 7/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias HomeCompletionHandler = (() -> Void)
class HomeViewModel<H> {
    var value: H {
        didSet {
            self.notify()
        }
    }
    
    init(_ value: H) {
        self.value = value
    }
    private var homeObservers = [String: HomeCompletionHandler]()
    public func addHomeObserver(_ observer: NSObject, homeCompletionHandler: @escaping CompletionHandler) {
        homeObservers[observer.description] = homeCompletionHandler
    }
    
    public func addAndNotify(observer: NSObject, homeCompletionHandler: @escaping CompletionHandler) {
        self.addHomeObserver(observer, homeCompletionHandler: homeCompletionHandler)
        self.notify()
    }
    
    private func notify() {
        homeObservers.forEach({ $0.value() })
    }
    
    deinit {
        homeObservers.removeAll()
    }
}
