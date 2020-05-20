//
//  MoviesListControllerConfigurator.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/20/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct MoviesListControllerConfigurator {
  static func configureSimpleMovies(router: MVVMRouter) -> MoviesListTableViewController {
    let factory = SimpleMoviesModelsFactory()
    return configureDefault(router: router, factory: factory)
  }
  
  static func configureFullMovies(router: MVVMRouter) -> MoviesListTableViewController {
    let factory = FullMoviesModelsFactory()
    return configureDefault(router: router, factory: factory)
  }
  
  // MARK: Private
  
  private static func configureDefault(router: MVVMRouter, factory: MoviesModelsFactory) -> MoviesListTableViewController {
    let store = MoviesListNetworkStore()
    let worker = MoviesListWorker(store: store)
    let viewModel = MoviesListViewModel(router: router, worker: worker, moviesFactory: factory)
    let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(identifier: "MoviesListTableViewController") as! MoviesListTableViewController
    viewController.viewModel = viewModel
    return viewController
  }
}
