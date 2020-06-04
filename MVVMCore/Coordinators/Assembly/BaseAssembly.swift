//
//  Assembly.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 04.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

final class BaseCoordinatorAssembly: CoordinatorAssembly {
  func makeCoordinator<T>(of type: T.Type, with window: UIWindow) -> T {
    switch String(describing: type) {
    case String(describing: MainCoordinatorProtocol.self):
      return makeMainCoordinator(with: window) as! T
    case String(describing: CounterCoordinatorProtocol.self):
      return makeCounterCoordinator(with: window) as! T
    case String(describing: MoviesCoordinatorProtocol.self):
      return makeMoviesCoordinator(with: window) as! T
    default:
      fatalError("Need to implement coordinator of type \(String(describing: type))")
    }
  }
}

private typealias CoordinatorFactory = BaseCoordinatorAssembly
private extension CoordinatorFactory {
  func makeMainCoordinator(with window: UIWindow) -> MainCoordinatorProtocol {
    let coordinator: MainCoordinatorProtocol = MainCoordinator(assembly: self, window: window)
    let factory = MainCoordinatorFactory()
    let router = MainCoordinatorRouter(factory: factory)
    coordinator.router = router
    router.coordinator = coordinator
    return coordinator
  }
  
  func makeCounterCoordinator(with window: UIWindow) -> CounterCoordinatorProtocol {
    let coordinator = CounterCoordinator(assembly: self, window: window)
    let factory = CounterCoordinatorFactory()
    let router = CounterCoordinatorRouter(factory: factory)
    coordinator.router = router
    router.coordinator = coordinator
    return coordinator
  }
  
  func makeMoviesCoordinator(with window: UIWindow) -> MoviesCoordinatorProtocol {
    let coordinator = MoviesCoordinator(assembly: self, window: window)
    let factory = MoviesCoordinatorFactory()
    let router = MoviesCoordinatorRouter(factory: factory)
    coordinator.router = router
    router.coordinator = coordinator
    return coordinator
  }
}
