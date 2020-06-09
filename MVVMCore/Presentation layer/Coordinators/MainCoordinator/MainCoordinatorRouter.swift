//
//  MainCoordinatorRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MainDataPassing { }

protocol MainRoutingLogic {
  func routeToCounter()
  func routeToMovies(with type: MoviesCoordinatorModels.ViewType)
}

final class MainCoordinatorRouter: BaseCoordinatorRouter, MainDataPassing {
  weak var coordinator: MainCoordinatorProtocol?
  private let factory: MainCoordinatorFactoryProtocol
  
  init(factory: MainCoordinatorFactoryProtocol) {
    self.factory = factory
  }
  
  override func route(with window: UIWindow) {
    window.rootViewController = factory.makeMainController(with: self)
    window.makeKeyAndVisible()
    super.route(with: window)
  }
}

extension MainCoordinatorRouter: MainRoutingLogic {
  func routeToCounter() {
    coordinator?.showCounter()
  }
  
  func routeToMovies(with type: MoviesCoordinatorModels.ViewType) {
    coordinator?.showMovies(with: type)
  }
}
