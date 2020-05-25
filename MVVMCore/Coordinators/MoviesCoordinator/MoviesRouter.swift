//
//  MoviesRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MoviesRouter: BaseRouter {
  
  enum Context {
    case setupSimple
    case setupFull
    
    var modelsFactory: MoviesModelsFactory {
      switch self {
      case .setupSimple: return SimpleMoviesModelsFactory()
      case .setupFull: return FullMoviesModelsFactory()
      }
    }
  }
  
  weak var coordinator: MoviesCoordinatorProtocol?
  var type: Context!
  private let factory: MoviesFactoryProtocol
  
  init(factory: MoviesFactoryProtocol) {
    self.factory = factory
  }
  
  override func route(with window: UIWindow) {
    super.route(with: window)
    let viewController = factory.makeMovieController(with: self, factory: type.modelsFactory)
    navigationController?.delegate = self
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension MoviesRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard
      let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
      !navigationController.viewControllers.contains(fromViewController),
      fromViewController is MoviesListTableViewController
    else { return }
    coordinator?.stop()
  }
}
