//
//  MoviesCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

final class MoviesCoordinator: BaseCoordinator<MoviesCoordinatorFactoryProtocol> {
  
  var moviesModelsFactory: MoviesModelsFactory
  
  init(assembly: CoordinatorAssembly,
       navigationController: UINavigationController,
       factory: MoviesCoordinatorFactoryProtocol,
       moviesModelsFactory: MoviesModelsFactory) {
    self.moviesModelsFactory = moviesModelsFactory
    super.init(assembly: assembly, navigationController: navigationController, factory: factory)
  }
  
  override func start() {
    let viewController = factory.makeMovieController(with: moviesModelsFactory)
    navigationController.pushViewController(viewController, animated: true)
  }
  
}
