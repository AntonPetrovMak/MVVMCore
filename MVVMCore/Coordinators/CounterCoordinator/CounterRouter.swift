//
//  CounterRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class CounterRouter: BaseRouter {
  
  enum Context {
    case pushForward(count: Observable<Int>)
    case presentForward(count: Observable<Int>)
  }
  
  weak var coordinator: CounterCoordinatorProtocol?
  private let factory: CounterFactoryProtocol
  
  init(factory: CounterFactoryProtocol) {
    self.factory = factory
  }
  
  override func route(with window: UIWindow) {
    super.route(with: window)
    let viewController = factory.makeCounterController(with: self)
    navigationController?.delegate = self
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  override func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
    guard let context = context as? Context else { return }
    
    switch context {
    case .pushForward(let count):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: true)
      navigationController?.pushViewController(viewController, animated: true)
    case .presentForward(let count):
      let viewController = factory.makeCounterDetailsController(with: self, count: count, isDismissButtonHidden: false)
      navigationController?.present(viewController, animated: true)
    }
  }
  
  override func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    navigationController?.presentedViewController?.dismiss(animated: animated, completion: nil)
  }
}

extension CounterRouter: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    guard
      let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
      !navigationController.viewControllers.contains(fromViewController),
      fromViewController is TestViewController
    else { return }
    coordinator?.stop()
  }
}
