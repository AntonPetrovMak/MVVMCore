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
  func showSimpleMovies()
  func showFullMovies()
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
  
  func showSimpleMovies() {
    
  }
  
  func showFullMovies() {
    
  }
}
