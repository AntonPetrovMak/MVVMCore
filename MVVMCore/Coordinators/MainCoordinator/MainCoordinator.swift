//
//  MainCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
  var router: (MainDataPassing & CoordinatorRouting)! { get set }
  
  func showCounter()
  func showMovies(with type: MoviesCoordinatorModels.ViewType)
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol {
  var router: (MainDataPassing & CoordinatorRouting)!
  
  override func start() {
    router.route(with: window)
  }
  
  func showCounter() {
    let coordinator = assembly.makeCoordinator(of: CounterCoordinatorProtocol.self, with: window)
    start(coordinator: coordinator)
  }
  
  func showMovies(with type: MoviesCoordinatorModels.ViewType) {
    let coordinator = assembly.makeCoordinator(of: MoviesCoordinatorProtocol.self, with: window)
    coordinator.router.type = type
    start(coordinator: coordinator)
  }
}
