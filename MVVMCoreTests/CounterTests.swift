//
//  CounterTests.swift
//  MVVMCoreTests
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import XCTest
@testable import MVVMCore

class EmptyTestRouter: MVVMRouter {
  var baseViewController: UIViewController?
}

class CounterTests: XCTestCase {
  
  override func setUp() {
    
  }
  
  func testCounterBackTransferDataSuccess() {
    let viewModel = TestViewModel(with: EmptyTestRouter())
    XCTAssertEqual(viewModel.count.value, 0)
    let detailsViewModel = TestDetailsViewModel(with: EmptyTestRouter(),
                                                count: viewModel.count,
                                                isDismissButtonHidden: true,
                                                mainFullMoviesObserver: nil)
    detailsViewModel.increaseCounter()
    XCTAssertEqual(viewModel.count.value, 1)
    detailsViewModel.decreaseCounter()
    detailsViewModel.decreaseCounter()
    XCTAssertEqual(viewModel.count.value, -1)
  }
  
}
