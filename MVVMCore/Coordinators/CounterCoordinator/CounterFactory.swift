//
//  CounterFactory.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterFactoryProtocol {
  func makeCounterController(with routing: MVVMRouter) -> UIViewController
  func makeCounterDetailsController(with routing: MVVMRouter, count: Observable<Int>, isDismissButtonHidden: Bool) -> UIViewController
}

class CounterFactory: CounterFactoryProtocol {
  func makeCounterController(with routing: MVVMRouter) -> UIViewController {
    let viewModel = TestViewModel(with: routing)
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TestViewController") as! TestViewController
    viewController.viewModel = viewModel
    return viewController
  }
  
  func makeCounterDetailsController(with routing: MVVMRouter, count: Observable<Int>, isDismissButtonHidden: Bool) -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TestDetailsViewController") as! TestDetailsViewController
    let viewModel = TestDetailsViewModel(with: routing, count: count, isDismissButtonHidden: isDismissButtonHidden)
    viewController.viewModel = viewModel
    return viewController
  }
}
