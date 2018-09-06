//
//  DynamicBarberValue.swift
//  BarberShop-V2
//
//  Created by User on 6/16/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionBarberUsernameHandler = (() -> Void)
class DynamicBarberUserNameValue<B> {
    
    var value: B {
        didSet{
            self.notify()
        }
    }
    private var barberTitleObserver = [String: CompletionBarberUsernameHandler]()
    
        init(_ value: B){
            self.value = value
        }
 
    public func addbarberTitleObservers(_ observer:NSObject, completionHandler:@escaping CompletionBarberUsernameHandler){
        barberTitleObserver[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionBarberUsernameHandler){
        self.addbarberTitleObservers(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        barberTitleObserver.forEach({ $0.value() })
    }
    deinit {
        barberTitleObserver.removeAll()
    }
    
}
