//
//  CounterCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterRoutingLogic {
  func routeWithPushDetails(count: Int, didChangeCount: @escaping (Int) -> Void)
  func routeWithPresentDetails(count: Int, didChangeCount: @escaping (Int) -> Void)
}

final class CounterCoordinator: BaseCoordinator<CounterCoordinatorFactoryProtocol> {
  
  private var isDismissButtonHidden: Bool
  
  init(assembly: CoordinatorAssembly, navigationController: UINavigationController, factory: CounterCoordinatorFactoryProtocol, isDismissButtonHidden: Bool) {
    self.isDismissButtonHidden = isDismissButtonHidden
    super.init(assembly: assembly, navigationController: navigationController, factory: factory)
  }
  
  override func createRootViewController() -> UIViewController {
    return factory.makeCounterController(with: self, isDismissButtonHidden: !isDismissButtonHidden)
  }
  
}

// MARK: - CounterRoutingLogic

extension CounterCoordinator: CounterRoutingLogic {

  func routeWithPushDetails(count: Int, didChangeCount: @escaping (Int) -> Void) {
    let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: true, didChangeCount: didChangeCount)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func routeWithPresentDetails(count: Int, didChangeCount: @escaping (Int) -> Void) {
    let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: false, didChangeCount: didChangeCount)
    navigationController.present(viewController, animated: true)
  }
  
  
}

// MARK: - CounterDetailsRoutingLogic

extension CounterCoordinator: CounterDetailsRoutingLogic {
  
  func routeToRoot() {
    if isDismissButtonHidden {
      navigationController.dismiss(animated: true, completion: nil)
    } else {
      navigationController.popToRootViewController(animated: true)
      navigationController.presentedViewController?.dismiss(animated: true, completion: nil)
    }
  }
  
}

