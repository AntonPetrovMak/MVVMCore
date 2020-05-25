//
//  CounterFactory.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterFactoryProtocol {
  func makeCounterController(with router: MVVMRouter) -> UIViewController
  func makeCounterDetailsController(with router: MVVMRouter, count: Observable<Int>, isDismissButtonHidden: Bool) -> UIViewController
}

class CounterFactory: CounterFactoryProtocol {
  func makeCounterController(with router: MVVMRouter) -> UIViewController {
    let viewModel = TestViewModel(with: router)
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TestViewController") as! TestViewController
    viewController.viewModel = viewModel
    return viewController
  }
  
  func makeCounterDetailsController(with router: MVVMRouter, count: Observable<Int>, isDismissButtonHidden: Bool) -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TestDetailsViewController") as! TestDetailsViewController
    let viewModel = TestDetailsViewModel(with: router, count: count, isDismissButtonHidden: isDismissButtonHidden)
    viewController.viewModel = viewModel
    return viewController
  }
}
