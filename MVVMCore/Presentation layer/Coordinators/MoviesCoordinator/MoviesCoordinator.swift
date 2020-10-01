//
//  MoviesCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesRoutingLogic {
  func routeToCounter()
}

final class MoviesCoordinator: BaseCoordinator<MoviesCoordinatorFactoryProtocol> {
  
  var moviesModelsFactory: MoviesModelsFactory
  
  init(assembly: CoordinatorAssembly,
       navigationController: UINavigationController?,
       factory: MoviesCoordinatorFactoryProtocol,
       moviesModelsFactory: MoviesModelsFactory) {
    self.moviesModelsFactory = moviesModelsFactory
    super.init(assembly: assembly, navigationController: navigationController, factory: factory)
  }
  
  override func start() {
    let viewController = factory.makeMovieController(with: self, factory: moviesModelsFactory)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
}

// MARK: - MoviesRoutingLogic

extension MoviesCoordinator: MoviesRoutingLogic {
  
  func routeToCounter() {
    let coordinator = assembly.makeCounterCoordinator(with: navigationController, modalView: false)
    start(coordinator: coordinator)
  }
  
}
