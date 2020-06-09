//
//  CounterTests.swift
//  MVVMCoreTests
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import XCTest
@testable import MVVMCore

class CounterTests: XCTestCase {
  
  override func setUp() {
    
  }
  
  func testCounterBackTransferDataSuccess() {
    let factory = CounterCoordinatorFactory()
    let router = CounterCoordinatorRouter(factory: factory)
    let viewModel = TestViewModel(with: router)
    XCTAssertEqual(viewModel.count.value, 0)
    let detailsViewModel = TestDetailsViewModel(with: router,
                                                count: viewModel.count,
                                                isDismissButtonHidden: true)
    detailsViewModel.increaseCounter()
    XCTAssertEqual(viewModel.count.value, 1)
    detailsViewModel.decreaseCounter()
    detailsViewModel.decreaseCounter()
    XCTAssertEqual(viewModel.count.value, -1)
  }
  
}
