//
//  CounterCoordinatorFactory.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterCoordinatorFactoryProtocol {
  func makeCounterController(with router: CounterRoutingLogic) -> UIViewController
  func makeCounterDetailsController(with router: CounterDetailsRoutingLogic, count: Observable<Int>, isDismissButtonHidden: Bool) -> UIViewController
}

final class CounterCoordinatorFactory: CounterCoordinatorFactoryProtocol {
  func makeCounterController(with router: CounterRoutingLogic) -> UIViewController {
    let viewModel = TestViewModel(with: router)
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TestViewController") as! TestViewController
    viewController.viewModel = viewModel
    return viewController
  }
  
  func makeCounterDetailsController(with router: CounterDetailsRoutingLogic, count: Observable<Int>, isDismissButtonHidden: Bool) -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TestDetailsViewController") as! TestDetailsViewController
    let viewModel = TestDetailsViewModel(with: router, count: count, isDismissButtonHidden: isDismissButtonHidden)
    viewController.viewModel = viewModel
    return viewController
  }
}
