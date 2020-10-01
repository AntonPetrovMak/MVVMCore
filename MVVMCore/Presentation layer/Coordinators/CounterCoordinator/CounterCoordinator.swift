//
//  CounterCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterRoutingLogic {
  func routeToDetails(with context: CounterCoordinatorModels.Context)
}

final class CounterCoordinator: BaseCoordinator<CounterCoordinatorFactoryProtocol> {
  
  private var modalView: Bool
  
  init(assembly: CoordinatorAssembly, navigationController: UINavigationController?, factory: CounterCoordinatorFactoryProtocol, modalView: Bool) {
    self.modalView = modalView
    super.init(assembly: assembly, navigationController: navigationController, factory: factory)
  }
  
  override func setupRootViewController() -> UIViewController {
    return factory.makeCounterController(with: self, isDismissButtonHidden: !modalView)
  }
  
}

// MARK: - CounterRoutingLogic

extension CounterCoordinator: CounterRoutingLogic {
  
  func routeToDetails(with context: CounterCoordinatorModels.Context) {
    switch context {
    case .pushForward(let count, let didChangeCount):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: true, didChangeCount: didChangeCount)
      navigationController?.pushViewController(viewController, animated: true)
    case .presentForward(let count, let didChangeCount):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: false, didChangeCount: didChangeCount)
      navigationController?.present(viewController, animated: true)
    }
  }
  
}

// MARK: - CounterDetailsRoutingLogic

extension CounterCoordinator: CounterDetailsRoutingLogic {
  
  func routeToRoot() {
    if modalView {
      navigationController?.dismiss(animated: true, completion: nil)
    } else {
      navigationController?.popToRootViewController(animated: true)
      navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
  }
  
}

