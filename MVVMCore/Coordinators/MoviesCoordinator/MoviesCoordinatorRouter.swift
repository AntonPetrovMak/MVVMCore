//
//  MoviesCoordinatorRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesDataPassing {
  var type: MoviesCoordinatorModels.ViewType! { get set }
}

final class MoviesCoordinatorRouter: BaseCoordinatorRouter, MoviesDataPassing {
  weak var coordinator: MoviesCoordinatorProtocol?
  var type: MoviesCoordinatorModels.ViewType!
  private let factory: MoviesCoordinatorFactoryProtocol
  
  init(factory: MoviesCoordinatorFactoryProtocol) {
    self.factory = factory
  }
  
  override func route(with window: UIWindow) {
    super.route(with: window)
    let viewController = factory.makeMovieController(with: type.modelsFactory)
    navigationController?.delegate = self
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension MoviesCoordinatorRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard
      let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
      !navigationController.viewControllers.contains(fromViewController),
      fromViewController is MoviesListTableViewController
    else { return }
    coordinator?.stop()
  }
}
