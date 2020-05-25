//
//  MoviesFactory.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesFactoryProtocol {
  func makeMovieController(with router: MVVMRouter, factory: MoviesModelsFactory) -> UIViewController
}

class MoviesFactory: MoviesFactoryProtocol {
  func makeMovieController(with router: MVVMRouter, factory: MoviesModelsFactory) -> UIViewController {
    let store = MoviesListNetworkStore()
    let worker = MoviesListWorker(store: store)
    let viewModel = MoviesListViewModel(router: router, worker: worker, moviesFactory: factory)
    let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(identifier: "MoviesListTableViewController") as! MoviesListTableViewController
    viewController.viewModel = viewModel
    return viewController
  }
}
