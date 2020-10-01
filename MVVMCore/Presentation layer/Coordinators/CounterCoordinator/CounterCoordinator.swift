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
  
  init(assembly: CoordinatorAssembly, navigationController: UINavigationController, factory: CounterCoordinatorFactoryProtocol, modalView: Bool) {
    self.modalView = modalView
    super.init(assembly: assembly, navigationController: navigationController, factory: factory)
  }
  
  override func start() {
    let viewController = factory.makeCounterController(with: self, isDismissButtonHidden: !modalView)
    if modalView {
      navigationController = UINavigationController(rootViewController: viewController)
      navigationController.modalPresentationStyle = .fullScreen
      //navigationController.presentationController?.delegate = self
      parentCoordinator?.navigationController.present(navigationController, animated: true, completion: nil)
    } else {
      navigationController.pushViewController(viewController, animated: true)
    }
  }
  
  deinit {
    print(#function + "\(String(describing: self))")
  }
}


extension CounterCoordinator: UIAdaptivePresentationControllerDelegate {

  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    stop()
  }

}

// MARK: - CounterRoutingLogic

extension CounterCoordinator: CounterRoutingLogic {
  
  func routeToDetails(with context: CounterCoordinatorModels.Context) {
    switch context {
    case .pushForward(let count):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: true)
      navigationController.pushViewController(viewController, animated: true)
    case .presentForward(let count):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: false)
      navigationController.present(viewController, animated: true)
    }
  }
  
}

// MARK: - CounterDetailsRoutingLogic

extension CounterCoordinator: CounterDetailsRoutingLogic {
  
  func routeToRoot() {
    navigationController.presentedViewController?.dismiss(animated: true, completion: nil)
  }
  
}

