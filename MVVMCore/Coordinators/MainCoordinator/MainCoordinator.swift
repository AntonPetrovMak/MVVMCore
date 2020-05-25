//
//  MainCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
  func showCounter()
  func showMovies(with type: MoviesRouter.Context)
}

class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol {
  private let router: BaseRouter
  
  override init(window: UIWindow) {
    let router = MainRouter(factory: MainFactory())
    self.router = router
    super.init(window: window)
    router.coordinator = self
  }
  
  override func start() {
    router.route(with: window)
  }
  
  func showCounter() {
    let coordinator = CounterCoordinator(window: window)
    start(coordinator: coordinator)
  }
  
  func showMovies(with type: MoviesRouter.Context) {
    let router = MoviesRouter(factory: MoviesFactory())
    router.type = type
    let coordinator = MoviesCoordinator(window: window)
    coordinator.router = router
    router.coordinator = coordinator
    start(coordinator: coordinator)
  }
}
