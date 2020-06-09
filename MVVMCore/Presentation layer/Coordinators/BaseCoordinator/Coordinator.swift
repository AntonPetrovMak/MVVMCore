//
//  Coordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

protocol Coordinator: class {
  
  /// Present coordinator
  func start()
  
  /// Present child coordinator
  /// - Parameters:
  ///   - coordinator: child coordinator
  func start(coordinator: Coordinator)
  
  /// Remove coordinator from stack
  func stop()
  
  /// Get child coordinator
  /// - Parameters:
  ///   - type: coordinator type
  func child<T>(of type: T.Type) -> T?
}
