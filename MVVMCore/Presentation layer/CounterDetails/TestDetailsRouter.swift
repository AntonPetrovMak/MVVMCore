//
//  TestDetailsRouter.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

import UIKit
class TestDetailsRouter: MVVMRouter {
  
  enum Context {
    case setup(count: Observable<Int>, isPresentOption: Bool)
  }
  
  var baseViewController: UIViewController?
  
  func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    guard let context = context as? Context else { return }
    switch context {
    case .setup(let count, let isPresentOption):
      if isPresentOption {
        let viewController = TestDetailsConfigurator.configurePresentStyle(router: self, count: count)
        baseVC.present(viewController, animated: true, completion: nil)
      } else {
        let viewController = TestDetailsConfigurator.configurePushStyle(router: self, count: count)
        baseVC.navigationController?.pushViewController(viewController, animated: true)
      }
      baseViewController = baseVC
    }
  }
  
  func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
    
  }
  
  func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    baseViewController?.presentedViewController?.dismiss(animated: animated, completion: nil)
  }
}
