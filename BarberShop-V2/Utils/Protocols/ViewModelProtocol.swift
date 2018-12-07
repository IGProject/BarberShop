//
//  ViewModelProtocol.swift
//  BarberShop-V2
//
//  Created by User on 11/14/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
  
  /// Base for all controller viewModels.
  ///
  /// It contains Input and Output types, usually expressed as nested structs inside a class implementation.
  ///
  /// Input type should contain observers (e.g. AnyObserver) that should be subscribed to UI elements that emit input events.
  ///
  /// Output type should contain observables that emit events related to result of processing of inputs.
  
  associatedtype Input
  associatedtype Output
}
