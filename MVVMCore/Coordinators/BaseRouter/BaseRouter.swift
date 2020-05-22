//
//  BaseRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class BaseRouter: NSObject, Router, MVVMRouter {
  weak var window: UIWindow?
  weak var navigationController: UINavigationController?
  weak var baseViewController: UIViewController?
  
  func route(with window: UIWindow) {
    self.window = window
    (window.rootViewController as? UINavigationController).map {
      navigationController = $0
      baseViewController = $0.viewControllers.first
    }
  }
  
  func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) { }
  
  func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) { }
}
