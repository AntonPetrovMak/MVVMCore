//
//  Coordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

protocol Coordinator: class {
  func start()
  func start(coordinator: Coordinator)
  func stop()
  func child<T>(of type: T.Type) -> T?
}
