//
//  MainViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/20/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol MainViewModelInput {
  func showCounter()
  func showSimpleMovies()
  func showFullMovies()
}

protocol MainViewModelProtocol: MainViewModelInput { }

final class MainViewModel: MainViewModelProtocol, MVVMViewModel {
  
  let router: MVVMRouter
  
  let fullMoviesObserver = ObservableEmpty()
  
  init(router: MVVMRouter) {
    self.router = router
    fullMoviesObserver.observe(on: self) { [weak self] in self?.showFullMovies() }
  }
  
  // MARK: - MainViewModelInput
  
  func showCounter() {
    let context = MainRouter.Context.counter(fullMoviesObserver: fullMoviesObserver)
    router.route(with: context)
  }
  
  func showSimpleMovies() {
    let context = MainRouter.Context.simpleMovies
    router.route(with: context)
  }
   
  func showFullMovies() {
    let context = MainRouter.Context.fullMovies
    router.route(with: context)
  }
  
}
