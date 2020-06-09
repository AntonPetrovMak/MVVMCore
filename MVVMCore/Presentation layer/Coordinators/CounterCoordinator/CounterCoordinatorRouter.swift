//
//  CounterRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterDataPassing { }

protocol CounterRoutingLogic {
  func routeToDetails(with context: CounterCoordinatorModels.Context)
}

protocol CounterDetailsRoutingLogic {
  func routeToRoot()
}

final class CounterCoordinatorRouter: BaseCoordinatorRouter, CounterDataPassing {
  weak var coordinator: CounterCoordinatorProtocol?
  private let factory: CounterCoordinatorFactoryProtocol
  
  init(factory: CounterCoordinatorFactoryProtocol) {
    self.factory = factory
  }
  
  override func route(with window: UIWindow) {
    super.route(with: window)
    let viewController = factory.makeCounterController(with: self)
    navigationController?.delegate = self
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension CounterCoordinatorRouter: CounterRoutingLogic {
  func routeToDetails(with context: CounterCoordinatorModels.Context) {
    switch context {
    case .pushForward(let count):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: true)
      navigationController?.pushViewController(viewController, animated: true)
    case .presentForward(let count):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: false)
      navigationController?.present(viewController, animated: true)
    }
  }
}

extension CounterCoordinatorRouter: CounterDetailsRoutingLogic {
  func routeToRoot() {
    navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
  }
}

extension CounterCoordinatorRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard
      let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
      !navigationController.viewControllers.contains(fromViewController),
      fromViewController is TestViewController
    else { return }
    coordinator?.stop()
  }
}
