//
//  MoviesTests.swift
//  MVVMCoreTests
//
//  Created by Petrov Anton on 5/25/20.
//  Copyright © 2020 APM. All rights reserved.
//

import XCTest
@testable import MVVMCore

class MoviesTests: XCTestCase {
  
  override func setUp() {
    
  }
  
  func testMoviesSearchSuccess() {
    let mockStore = MoviesListMockStore()
    let worker = MoviesListWorker(store: mockStore)
    let viewModel = MoviesListViewModel(worker: worker,
                                        moviesFactory: FullMoviesModelsFactory())
    viewModel.loadMovies()
    XCTAssertEqual(viewModel.moviesViewModels.value.count, 5)
    viewModel.filterChanged("Spi")
    XCTAssertEqual(viewModel.moviesViewModels.value.count, 1)
    viewModel.filterChanged("Fro")
    XCTAssertEqual(viewModel.moviesViewModels.value.count, 2)
    viewModel.filterChanged("frortyu")
    XCTAssertEqual(viewModel.moviesViewModels.value.count, 0)
    viewModel.filterChanged("")
    XCTAssertEqual(viewModel.moviesViewModels.value.count, 5)
  }
}
