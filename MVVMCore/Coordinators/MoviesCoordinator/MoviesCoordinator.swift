//
//  MoviesCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesCoordinatorProtocol: Coordinator { }

class MoviesCoordinator: BaseCoordinator, MoviesCoordinatorProtocol {
  private let router: BaseRouter
  
  override init(window: UIWindow) {
    let router = MoviesRouter(factory: MoviesFactory())
    self.router = router
    super.init(window: window)
    router.coordinator = self
  }
  
  override func start() {
    router.route(with: window)
  }
}
