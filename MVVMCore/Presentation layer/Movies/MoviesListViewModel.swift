//
//  MoviesListViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol MoviesListViewModelInput {
  var screenTitle: String { get }
  func viewDidLoad()
  func pullToRefresh()
  func filterChanged(_ text: String)
  func showCounter()
}

protocol MoviesListViewModelOutput: BaseViewModelOutput {
  var moviesViewModels: Observable<[MoviesTableViewModel]> { get }
}

protocol MoviesListViewModelProtocol: MoviesListViewModelInput, MoviesListViewModelOutput { }

class MoviesListViewModel: MoviesListViewModelProtocol {
  
  // MARK: MVVMViewModel
  let worker: MoviesListWorkerProtocol
  let moviesFactory: MoviesModelsFactory
  let router: MoviesRoutingLogic
  
  init(router: MoviesRoutingLogic, worker: MoviesListWorkerProtocol, moviesFactory: MoviesModelsFactory) {
    self.router = router
    self.worker = worker
    self.moviesFactory = moviesFactory
  }
  
  // MARK: MoviesListViewModelOutput
  var moviesViewModels: Observable<[MoviesTableViewModel]> = Observable([])
  var isLoading: Observable<Bool> = Observable(false)
  var error: Observable<String?> = Observable(nil)
  
  private var filter: String = ""
  
  private var movies: [Movie] = [] {
    didSet { fetchMoviesViewModels() }
  }
  
  private func fetchMoviesViewModels() {
    moviesViewModels.value = movies
      .filter { $0.name.contains(filter) || filter.isEmpty }
      .map { moviesFactory.makeTableViewModel($0)}
  }
  
  //MARK: MoviesListViewModelInput
  
  var screenTitle: String {
    return moviesFactory.screenTitle
  }
  
  func viewDidLoad() {
    loadMovies()
  }
  
  func pullToRefresh() {
    loadMovies()
  }
  
  func filterChanged(_ text: String) {
    filter = text
    fetchMoviesViewModels()
  }
  
  func showCounter() {
    router.routeToCounter()
  }
  
  //MARK: Private
  
  func loadMovies() {
    isLoading.value = true
    worker.loadMoviesList { [weak self] (result) in
      guard let `self` = self else { return }
      self.isLoading.value = false
      switch result {
      case .success(let response):
        self.movies = response
      case .failure(let error):
        self.error.value = error.localizedDescription
      }
    }
  }
  
  deinit {
    print(#function + "\(String(describing: self))")
  }
}
