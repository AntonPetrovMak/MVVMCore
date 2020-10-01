//
//  CounterCoordinatorFactory.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterCoordinatorFactoryProtocol: class {
  func makeCounterController(with router: CounterRoutingLogic, isDismissButtonHidden: Bool) -> UIViewController
  func makeCounterDetailsController(with router: CounterDetailsRoutingLogic,
                                    count: Int,
                                    isDismissButtonHidden: Bool,
                                    didChangeCount: @escaping (Int) -> Void) -> UIViewController
}

final class CounterCoordinatorFactory: CounterCoordinatorFactoryProtocol {
  func makeCounterController(with router: CounterRoutingLogic, isDismissButtonHidden: Bool) -> UIViewController {
    let viewModel = CounterViewModel(with: router, isDismissButtonHidden: isDismissButtonHidden)
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CounterViewController") as! CounterViewController
    viewController.viewModel = viewModel
    return viewController
  }
  
  func makeCounterDetailsController(with router: CounterDetailsRoutingLogic, count: Int, isDismissButtonHidden: Bool,didChangeCount: @escaping (Int) -> Void) -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CounterDetailsViewController") as! CounterDetailsViewController
    let viewModel = CounterDetailsViewModel(with: router, count: count, isDismissButtonHidden: isDismissButtonHidden, didChangeCount: didChangeCount)
    viewController.viewModel = viewModel
    return viewController
  }

}
