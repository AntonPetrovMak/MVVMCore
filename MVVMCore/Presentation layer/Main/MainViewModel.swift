//
//  MainViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/20/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol MainViewModelInput {
  func showCounter(modalView: Bool)
  func showSimpleMovies()
  func showFullMovies()
}

protocol MainViewModelProtocol: MainViewModelInput { }

struct MainViewModel: MainViewModelProtocol {
  
  let router: MainRoutingLogic
  
  init(router: MainRoutingLogic) {
    self.router = router
  }
  
  // MARK: - MainViewModelInput
  
  func showCounter(modalView: Bool) {
    router.routeToCounter(modalView: modalView)
  }
  
  func showSimpleMovies() {
    router.routeToMovies(with: .setupSimple)
  }
   
  func showFullMovies() {
    router.routeToMovies(with: .setupFull)
  }
  
}
