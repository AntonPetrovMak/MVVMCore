//
//  MainCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
  func routeToCounter(modalView: Bool)
  func routeToMovies(with type: MoviesCoordinatorModels.ViewType)
}

final class MainCoordinator: BaseCoordinator<MainCoordinatorFactoryProtocol> {
  
  override func setupRootViewController() -> UIViewController {
    return factory.makeMainController(with: self)
  }
  
}

// MARK: MainRoutingLogic

extension MainCoordinator: MainRoutingLogic {
  
  func routeToCounter(modalView: Bool) {
    let coordinator = assembly.makeCounterCoordinator(with: navigationController, modalView: modalView)
    start(coordinator: coordinator, style: modalView ? .presentSecondarySteck : .push)
  }
  
  func routeToMovies(with type: MoviesCoordinatorModels.ViewType) {
    let coordinator = assembly.makeMoviesCoordinator(with: navigationController, moviesModelsFactory: type.modelsFactory)
    start(coordinator: coordinator, style: .push)
  }
  
}
