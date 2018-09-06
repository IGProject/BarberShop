//
//  DynamicBookingValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

typealias CompletionBookingHandler = (() -> Void)

class DynamicBookingValue<S>{
    var value: S {
        didSet{
            self.notify()
        }
    }
    private var bookingObServers = [String: CompletionBookingHandler]()
    
    init(_ value: S) {
        self.value = value
    }
    
    public func addBookingObServer(_ observer:NSObject, completionHandler:@escaping CompletionBookingHandler){
        bookingObServers[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionServiceHandler){
        self.addBookingObServer(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        bookingObServers.forEach({ $0.value() })
    }
    deinit {
        bookingObServers.removeAll()
    }
}
