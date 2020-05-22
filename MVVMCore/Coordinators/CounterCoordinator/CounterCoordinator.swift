//
//  CounterCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterCoordinatorProtocol: Coordinator { }

class CounterCoordinator: BaseCoordinator, CounterCoordinatorProtocol {
  private let router: BaseRouter
  
  override init(window: UIWindow) {
    let router = CounterRouter(factory: CounterFactory())
    self.router = router
    super.init(window: window)
    router.coordinator = self
  }
  
  override func start() {
    router.route(with: window)
  }
}
