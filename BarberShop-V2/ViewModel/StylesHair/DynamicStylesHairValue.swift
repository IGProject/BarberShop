//
//  DynamicStylesHairValue.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
typealias CompletionStylesHairHandler = (() -> Void)

class DynamicStylesHairValue<H> {
    var value: H {
        didSet{
            self.notify()
        }
    }
    private var stylesHairObServers = [String: CompletionStylesHairHandler]()
    
    init(_ value: H) {
        self.value = value
    }
    
    public func addStyleHairObServer(_ observer:NSObject, completionHandler:@escaping CompletionStylesHairHandler){
        stylesHairObServers[observer.description] = completionHandler
    }
    
    public func addNotify(observier:NSObject, completionHandler:@escaping CompletionStylesHairHandler){
        self.addStyleHairObServer(observier, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify(){
        stylesHairObServers.forEach({ $0.value() })
    }
    deinit {
        stylesHairObServers.removeAll()
    }
    
}
